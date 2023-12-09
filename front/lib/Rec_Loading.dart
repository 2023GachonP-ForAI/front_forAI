import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import './result.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class RecLoading extends StatefulWidget {
  final String path;

  const RecLoading({Key? key, required this.path}) : super(key: key);

  @override
  _RecLoadingState createState() => _RecLoadingState();
}

class _RecLoadingState extends State<RecLoading> {
  late int _sweetResult;

  @override
  void initState() {
    super.initState();
    _uploadFile();
  }

  Future<void> _uploadFile() async {
    try {
      var uri = Uri.parse(
          'http://ceprj.gachon.ac.kr:60019/result/sweet'); // 서버 엔드포인트를 설정
      var request = http.MultipartRequest('POST', uri);
      //    print(widget.path);
      // request.files.add(await http.MultipartFile.fromPath('file', widget.path));

      request.files.add(
        await http.MultipartFile.fromPath('file', widget.path,
            contentType: MediaType('audio', 'x-wav')),
      );

      var response = await request.send();

      // print(response.statusCode);

      // 응답을 받을 때까지 대기
      var responseBody = await http.Response.fromStream(response);

      //  print(responseBody.statusCode);
      // print(responseBody.body);

      if (response.statusCode == 200) {
        var jsonData = json.decode(responseBody.body);
        print(jsonData);
        _sweetResult = jsonData['sweet'];
        //     _sweetResult = int.parse(responseBody.body);

        print("당도결과 $_sweetResult");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Result(sweetResult: _sweetResult),
          ),
        );
      } else {
        print(
            'Failed to upload file. Server responded with status ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading file: $error');
    }
  }

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
          Stack(children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 38, 118, 41),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '열심히 분석 중이에요!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontFamily: 'DoH'),
            ),
            const SizedBox(
              height: 40,
            ),
            //        const Text('Play Recorded Audio'),
            LoadingAnimationWidget.hexagonDots(color: Colors.red, size: 200)
          ],
          //  ),
          //  ),
        ),
      ]),
    );
  }

  void _playAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(DeviceFileSource(widget.path));
    print(widget.path);
  }
}
