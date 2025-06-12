import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

import '../views/home/voice_identifier/ai_analysis_screen.dart';
import '../views/home/voice_identifier/bird_photo_screen.dart';
import '../views/home/voice_identifier/scan_bird_screen.dart';

class BirdSoundController extends GetxController {
  // Options and navigation
  var selectedOption = 'By Sound'.obs;

  // Audio recording
  late final RecorderController recorderController;
  final flutterSoundRecorder = FlutterSoundRecorder();
  var isRecording = false.obs;
  var timer = "00:00:00".obs;
  var recordedFilePath = ''.obs;
  StreamSubscription<String>? timerInterval;
  var shouldNavigateToAnalysis = false.obs;

  // API and processing
  var isUploadingAudio = false.obs;
  var uploadProgress = 0.0.obs;
  var apiResponse = ''.obs;

  // Photo handling
  var isProcessing = false.obs;
  var imageFile = Rx<File?>(null);

  // Add your API configuration here
  static const String baseUrl =
      'https://your-api-endpoint.com'; // Replace with your actual API URL
  static const String audioAnalysisEndpoint = '/api/analyze-bird-sound';

  @override
  void onInit() {
    super.onInit();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    try {
      recorderController =
          RecorderController()
            ..androidEncoder = AndroidEncoder.aac
            ..androidOutputFormat = AndroidOutputFormat.mpeg4
            ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
            ..sampleRate = 44100;

      await flutterSoundRecorder.openRecorder();
      await flutterSoundRecorder.setSubscriptionDuration(
        const Duration(milliseconds: 100),
      );
    } catch (e) {
      _showError('Failed to initialize recorder: ${e.toString()}');
    }
  }

  void selectOption(String option) {
    selectedOption.value = option;
  }

  Future<void> toggleRecording() async {
    if (isRecording.value) {
      await stopRecording();
    } else {
      await startRecording();
    }
  }

  Future<void> startRecording() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      _showError('Microphone access is needed to record');
      return;
    }

    try {
      // Reset states
      isRecording.value = true;
      shouldNavigateToAnalysis.value = false;
      timer.value = "00:00:00";
      recordedFilePath.value = '';
      apiResponse.value = '';

      // Start recording
      await recorderController.record();
      await flutterSoundRecorder.startRecorder(toFile: 'audio_recording.wav');

      _startTimer();
    } catch (e) {
      isRecording.value = false;
      _showError('Failed to start recording: ${e.toString()}');
    }
  }

  void _startTimer() {
    int seconds = 0;
    timerInterval = Stream.periodic(const Duration(seconds: 1), (_) {
      if (isRecording.value) {
        seconds++;
        final hours = seconds ~/ 3600;
        final minutes = (seconds % 3600) ~/ 60;
        final secs = seconds % 60;
        return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
      }
      return timer.value;
    }).takeWhile((_) => isRecording.value).listen((time) => timer.value = time);
  }

  Future<void> stopRecording() async {
    try {
      isRecording.value = false;
      timerInterval?.cancel();

      // Stop recording and get file path
      recordedFilePath.value = await recorderController.stop() ?? '';
      await flutterSoundRecorder.stopRecorder();

      if (recordedFilePath.value.isNotEmpty) {
        _showSuccess('Recording saved successfully');

        // Upload to backend
        await _uploadAudioToBackend();

        // Navigate to analysis screen after upload
        shouldNavigateToAnalysis.value = true;
      } else {
        throw Exception('Failed to save recording');
      }
    } catch (e) {
      _showError('Failed to stop recording: ${e.toString()}');
    }
  }

  Future<void> _uploadAudioToBackend() async {
    if (recordedFilePath.value.isEmpty) {
      _showError('No audio file to upload');
      return;
    }

    try {
      isUploadingAudio.value = true;
      uploadProgress.value = 0.0;

      final file = File(recordedFilePath.value);
      if (!file.existsSync()) {
        throw Exception('Audio file not found');
      }

      // Create multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl$audioAnalysisEndpoint'),
      );

      // Add headers
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        // Add authentication headers if needed
        // 'Authorization': 'Bearer your-token',
      });

      // Add file
      final multipartFile = await http.MultipartFile.fromPath(
        'audio_file', // Field name expected by your backend
        file.path,
        filename: path.basename(file.path),
      );
      request.files.add(multipartFile);

      // Add additional fields if needed
      request.fields['timestamp'] = DateTime.now().toIso8601String();
      request.fields['duration'] = timer.value;

      // Send request with progress tracking
      final streamedResponse = await request.send();

      // Update progress
      uploadProgress.value = 1.0;

      // Get response
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        apiResponse.value = response.body;
        _showSuccess('Audio uploaded and analyzed successfully');
      } else {
        throw Exception(
          'Upload failed: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      _showError('Failed to upload audio: ${e.toString()}');
    } finally {
      isUploadingAudio.value = false;
      uploadProgress.value = 0.0;
    }
  }

  void handleNavigationToAnalysis() {
    shouldNavigateToAnalysis.value = false;
    Future.delayed(const Duration(seconds: 1), () {
      Get.to(() => const AiAnalysisScreen());
    });
  }

  void navigateBasedOnOption(String option) {
    selectOption(option);
    switch (option) {
      case 'Bird photo AI Enhance':
        Get.to(() => ScanBirdScreen());
        break;
      case 'By Photo':
        Get.to(() => BirdPhotoScreen());
        break;
      case 'By Sound':
        // Already on the sound screen
        break;
    }
  }

  // Photo handling methods
  Future<void> requestPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final photosStatus = await Permission.photos.request();

    if (!cameraStatus.isGranted || !photosStatus.isGranted) {
      _showError('Camera and gallery access are needed');
    }
  }

  Future<void> capturePhoto() async {
    try {
      isProcessing.value = true;
      await requestPermissions();
      final photo = await ImagePicker().pickImage(source: ImageSource.camera);
      if (photo != null) {
        imageFile.value = File(photo.path);
        _showSuccess('Photo captured successfully');
      }
    } catch (e) {
      _showError('Failed to capture photo: ${e.toString()}');
    } finally {
      isProcessing.value = false;
    }
  }

  Future<void> selectPhotoFromGallery() async {
    try {
      isProcessing.value = true;
      await requestPermissions();
      final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (photo != null) {
        imageFile.value = File(photo.path);
        _showSuccess('Photo selected successfully');
      }
    } catch (e) {
      _showError('Failed to select photo: ${e.toString()}');
    } finally {
      isProcessing.value = false;
    }
  }

  void confirmPhoto() {
    if (imageFile.value != null) {
      isProcessing.value = false;
      _showSuccess('Photo ready for processing');
    } else {
      _showError('No photo selected');
    }
  }

  // Utility methods
  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      duration: const Duration(seconds: 3),
    );
  }

  void _showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primary,
      colorText: Get.theme.colorScheme.onPrimary,
      duration: const Duration(seconds: 2),
    );
  }

  // Cleanup recording file if needed
  Future<void> deleteRecordingFile() async {
    if (recordedFilePath.value.isNotEmpty) {
      try {
        final file = File(recordedFilePath.value);
        if (file.existsSync()) {
          await file.delete();
          recordedFilePath.value = '';
        }
      } catch (e) {
        print('Failed to delete recording file: $e');
      }
    }
  }

  @override
  void onClose() {
    // Cleanup resources
    timerInterval?.cancel();
    recorderController.dispose();
    flutterSoundRecorder.closeRecorder();
    super.onClose();
  }
}
