import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RecLoading extends StatefulWidget {
  final String path;

  const RecLoading({Key? key, required this.path}) : super(key: key);

  @override
  _RecLoadingState createState() => _RecLoadingState();
}

class _RecLoadingState extends State<RecLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Recorded Audio'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _playAudio();
          },
          child: Column(
            children: [
              const Text('Play Recorded Audio'),
              LoadingAnimationWidget.hexagonDots(color: Colors.red, size: 200)
            ],
          ),
        ),
      ),
    );
  }

  void _playAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(DeviceFileSource(widget.path));
    print(widget.path);
  }
}
