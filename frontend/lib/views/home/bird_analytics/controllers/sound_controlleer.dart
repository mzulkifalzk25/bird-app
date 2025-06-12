import 'package:bird_discovery/views/home/bird_analytics/controllers/bird_analytics_controller.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class SoundController extends GetxController {
  /// Index of currently playing track, or -1 if none.
  final playingIndex = RxInt(-1);

  /// Underlying audio player
  final _player = AudioPlayer();
  final ctrl = Get.find<BirdAnalyticsController>();

  /// Paths to your audio assets
  List<String> paths = [];

  /// One waveform controller per track
  late final List<PlayerController> waveControllers;

  @override
  void onInit() {
    super.onInit();
    paths.clear();
    paths = ctrl.birdDetails.value!.sounds;
    waveControllers =
        paths.map((path) {
          final c = PlayerController();
          c.preparePlayer(path: path, shouldExtractWaveform: true);
          return c;
        }).toList();
  }

  /// Toggle play/pause for track [index]
  Future<void> toggle(int index) async {
    if (playingIndex.value == index) {
      await _player.stop();
      playingIndex.value = -1;
    } else {
      if (playingIndex.value >= 0) {
        await _player.stop();
      }
      playingIndex.value = index;
      await _player.play(DeviceFileSource(paths[index]));
    }
  }
}
