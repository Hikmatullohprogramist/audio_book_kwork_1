// ignore_for_file: unrelated_type_equality_checks

import 'package:audio_book_kwork_1/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class InfoScreen extends StatefulWidget {
  final String musicFilePaths;
  final String title;

  const InfoScreen({
    Key? key,
    required this.title,
    required this.musicFilePaths,
  }) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late AudioPlayer audioPlayer;
  int currentMusicIndex = 0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  void _initAudioPlayer() async {
    audioPlayer = AudioPlayer();

    try {
      await audioPlayer.setFilePath(widget.musicFilePaths);

      audioPlayer.playerStateStream.listen((playerState) {
        if (mounted) {
          // Add this check to ensure the widget is still in the tree
          setState(() {
            _isPlaying = playerState.playing;
          });
        }
      });
    } on Exception catch (e) {
      print("=================================================$e");
    }
  }

  void _playMusic(int index) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      if (index >= 0 && index < widget.musicFilePaths.length) {
        currentMusicIndex = index;
        await audioPlayer.stop();
        await audioPlayer.setFilePath(widget.musicFilePaths[currentMusicIndex]);
        audioPlayer.play();
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleWidget(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(22),
            height: 309,
            width: double.infinity,
            child: Image.asset(
              "assets/books/book_1.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder<Duration?>(
                      stream: audioPlayer.positionStream,
                      builder: (context, snapshot) {
                        final position = snapshot.data ?? Duration.zero;
                        String currentPosition = formatDuration(position);
                        return Text(
                          currentPosition,
                          style: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: StreamBuilder<Duration?>(
                        stream: audioPlayer.durationStream,
                        builder: (context, snapshot) {
                          final duration = snapshot.data ?? Duration.zero;
                          return StreamBuilder<Duration>(
                            stream: audioPlayer.positionStream,
                            builder: (context, snapshot) {
                              final position = snapshot.data ?? Duration.zero;
                              final double value = position.inMilliseconds
                                  .toDouble()
                                  .clamp(
                                      0.0, duration.inMilliseconds.toDouble());

                              return Slider(
                                value: value,
                                min: 0.0,
                                max: duration.inMilliseconds.toDouble(),
                                onChanged: (double value) {
                                  audioPlayer.seek(
                                      Duration(milliseconds: value.toInt()));
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    StreamBuilder<Duration?>(
                      stream: audioPlayer.durationStream,
                      builder: (context, snapshot) {
                        final duration = snapshot.data ?? Duration.zero;
                        String totalDuration = formatDuration(duration);
                        return Text(
                          totalDuration,
                          style: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous),
                    // Rewind to previous music
                    onPressed: () {
                      _playMusic(currentMusicIndex - 1);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.replay_10), // Rewind 10 seconds icon
                    onPressed: () {
                      final newPosition =
                          audioPlayer.position - const Duration(seconds: 10);
                      if (newPosition > Duration.zero) {
                        audioPlayer.seek(newPosition);
                      } else {
                        audioPlayer.seek(Duration.zero);
                      }
                    },
                  ),
                  IconButton(
                    icon: _isPlaying
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow),
                    onPressed: () {
                      if (_isPlaying) {
                        audioPlayer.pause();
                      } else {
                        audioPlayer.play();
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.forward_10),
                    onPressed: () {
                      final newPosition =
                          audioPlayer.position + const Duration(seconds: 10);
                      final maxDuration = audioPlayer.duration;
                      if (maxDuration != null && newPosition < maxDuration) {
                        audioPlayer.seek(newPosition);
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next), // Move to next music
                    onPressed: () {
                      _playMusic(currentMusicIndex + 1);
                    },
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}

String formatDuration(Duration duration) {
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
