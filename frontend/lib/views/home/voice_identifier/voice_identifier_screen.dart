import 'dart:ui' as ui;

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/voice_identifier_controller.dart';
import '../../../utils/app_images.dart';

class BirdSoundScreen extends StatelessWidget {
  final BirdSoundController controller = Get.put(BirdSoundController());

  BirdSoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: Obx(() => _buildBody()));
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Obx(
        () => Text(
          controller.isRecording.value
              ? 'Bird Voice Recording...'
              : 'Identify by Voice',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 18.sp,
          ),
        ),
      ),
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: CustomIconButton(
          onPressed: () => Get.back(),
          child: Image.asset(AppImages.arrowLeft, height: 16.h),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildBody() {
    // Handle navigation after recording stops
    if (controller.shouldNavigateToAnalysis.value) {
      controller.handleNavigationToAnalysis();
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWaveformSection(),
          SizedBox(height: 20.h),
          _buildTimerDisplay(),
          SizedBox(height: 30.h),
          _buildOptionButtons(),
          SizedBox(height: 30.h),
          _buildRecordingSection(),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildWaveformSection() {
    if (controller.isRecording.value) {
      return _buildLiveWaveform();
    } else if (controller.recordedFilePath.value.isNotEmpty) {
      return _buildRecordedWaveform();
    }
    return const SizedBox.shrink();
  }

  Widget _buildLiveWaveform() {
    return Container(
      height: 120.h,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: AudioWaveforms(
        enableGesture: false,
        recorderController: controller.recorderController,
        size: Size(MediaQuery.of(Get.context!).size.width, 120.h),
        waveStyle: WaveStyle(
          showMiddleLine: false,
          waveColor: AppColors.primaryColor,
          extendWaveform: true,
          waveThickness: 4,
          spacing: 6,
          showBottom: false,
          showTop: false,
        ),
      ),
    );
  }

  Widget _buildRecordedWaveform() {
    return Container(
      height: 120.h,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: AudioWaveforms(
        recorderController: controller.recorderController,
        size: Size(MediaQuery.of(Get.context!).size.width, 120.h),
        waveStyle: WaveStyle(
          showMiddleLine: false,
          waveColor: Colors.blue,
          extendWaveform: true,
          waveThickness: 4,
          spacing: 6,
          showBottom: false,
          showTop: false,
          gradient: ui.Gradient.linear(
            const Offset(0, 0),
            const Offset(0, 50),
            [Colors.blue.withOpacity(0.8), Colors.blue],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerDisplay() {
    return Container(
      padding: const EdgeInsets.all(9.0),
      decoration: BoxDecoration(
        color:
            controller.isRecording.value
                ? AppColors.primaryColor
                : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        controller.timer.value,
        style: TextStyle(
          fontSize: 30.sp,
          fontWeight: FontWeight.w600,
          color:
              controller.isRecording.value
                  ? AppColors.whiteColor
                  : AppColors.blackColor,
        ),
      ),
    );
  }

  Widget _buildOptionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildOptionButton('Bird photo AI Enhance'),
          _buildOptionButton('By Photo'),
          _buildOptionButton('By Sound'),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String text) {
    final isSelected = controller.selectedOption.value == text;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          controller.navigateBasedOnOption(text);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
          SizedBox(height: 4.h),
          if (isSelected)
            Container(
              height: 2.h,
              width: text.length * 5.w,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }

  Widget _buildRecordingSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: controller.toggleRecording,
          child: Image.asset(
            controller.isRecording.value
                ? AppImages.stopImage
                : AppImages.startImage,
            width: 70.w,
            height: 70.h,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          controller.isRecording.value
              ? 'Tap to stop recording'
              : 'Tap to start recording the bird\'s sound',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
