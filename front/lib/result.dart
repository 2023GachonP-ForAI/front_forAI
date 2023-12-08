import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final int sweetResult;

  const Result({Key? key, required this.sweetResult}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Play Recorded Audio'),
      // ),
      body:
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       _playAudio();
          //     },
          //     child:
          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Play Recorded Audio'),
          Text(widget.sweetResult.toString())
        ],
        //  ),
        //  ),
      ),
    );
  }
}
