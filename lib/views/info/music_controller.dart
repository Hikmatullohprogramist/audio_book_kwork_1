import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class MusicController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Rx<Duration?> _position = Rx<Duration?>(null);
  final Rx<Duration?> _duration = Rx<Duration?>(null);

  Stream<Duration?> get positionStream => _audioPlayer.positionStream;

  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  Duration get position => _position.value ?? Duration.zero;

  Duration get duration => _duration.value ?? Duration.zero;

  @override
  void onInit() {
    super.onInit();
    _position.bindStream(positionStream);
    _duration.bindStream(durationStream);
  }

  void seekTo(double milliseconds) {
    _audioPlayer.seek(Duration(milliseconds: milliseconds.toInt()));
  }
  // void _playMusic(int index) async {
  //   if (index >= 0 && index < widget.musicFilePaths.length) {
  //     currentMusicIndex = index;
  //     await _audioPlayer.stop();
  //     await _audioPlayer.setFilePath(widget.musicFilePaths[currentMusicIndex]);
  //     _audioPlayer.play();
  //   }
  // }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
