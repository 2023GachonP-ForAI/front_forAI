import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'Rec_Loading.dart';

class Rec extends StatefulWidget {
  const Rec({super.key});

  @override
  State<Rec> createState() => _RecState();
}

class _RecState extends State<Rec> {
  bool stopped = false;
  String path_copy = '';
  int _recordDuration = 0;
  Timer? _timer;
  final _Rec = Record();
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  String? path = '';
  AudioPlayer audioPlayer = AudioPlayer();
  bool _waiting = false;

  @override
  void initState() {
    _recordSub = _Rec.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
    });
    super.initState();
  }

  Future<void> _start() async {
    print("여기 왔나>");
    try {
      if (await _Rec.hasPermission()) {
        print('1');
        var myAppDir = await getAppDirectory();
        print('directory확인');
        // var id = await getId();
        var timestamp = DateTime.now().millisecondsSinceEpoch;
        var playerExtension =
            Platform.isAndroid ? '$timestamp.wav' : '$timestamp.flac';
        await _Rec.start(
          path: '$myAppDir/$playerExtension',
          encoder: Platform.isAndroid
              ? AudioEncoder.wav
              : AudioEncoder.flac, // by default
        );

        if (Platform.isAndroid) ('$myAppDir/$playerExtension');
        _recordState = RecordState.record;
        _recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {}
    }
  }

  Future<String> getAppDirectory() async {
    final directory = await getApplicationCacheDirectory();
    return directory.path;
  }

  Future<void> _stop() async {
    setState(() {
      stopped = true;
    });
    _timer?.cancel();
    _recordDuration = 0;
    path = await _Rec.stop(); //path받기
    print(path);
  }

  Future<void> _pause() async {
    playAudio();
    _timer?.cancel();
    await _Rec.pause();
  }

  // Future<void> _resume() async {
  //   _startTimer();
  //   await _Rec.resume();
  // }

  void playAudio() async {
    await audioPlayer.play(DeviceFileSource(path_copy));
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 28, 91, 30),
        ),
      ),
      const Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            Text(
              '30초 동안',
              style: TextStyle(
                  fontSize: 40, color: Color.fromARGB(255, 188, 28, 17)),
            ),
            Text('수박을 두드려 주세요', style: TextStyle(fontSize: 40))
          ],
        ),
      ),
      IconButton(
        padding: const EdgeInsets.all(30),
        icon: const Icon(
          Icons.clear,
          size: 50,
          color: Colors.black,
        ),
        onPressed: () async {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
      Center(
          child: Image.asset(
        'lib/images/watermelon_record.png',
        height: 350,
      )),
      Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: _buildRecordStopControl()),
      ),
      Visibility(
        //녹음 완료 팝업창
        visible: stopped,
        child: SizedBox(
          width: 400,
          child: AlertDialog(
            titlePadding: const EdgeInsets.only(
              top: 60,
              //  bottom: 20,
            ),
            actionsPadding: const EdgeInsets.only(
              bottom: 50,
              top: 30,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.white.withOpacity(0.9),
            title: const Center(
                child: Text(
              '확인을 누르면 \n당도를 측정해드려요!',
            )),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecLoading(
                                  // onStop: widget.onStop,
                                  path: path!,
                                )),
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 26, 255, 91),
                      ),
                      child: const Center(
                          child: Text(
                        '확인',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        stopped = false;
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 26, 255, 91),
                      ),
                      child: const Center(
                          child: Text(
                        '취소',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    ]));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _Rec.dispose();
    super.dispose();
  }

  Widget _buildRecordStopControl() {
    late Widget icon;

    if (_recordState != RecordState.stop) {
      _waiting = false;
      icon = const Icon(
        Icons.stop,
        size: 50,
        color: Color.fromARGB(255, 255, 0, 0),
      );
    } else if (_waiting) {
      icon = const CircularProgressIndicator(color: Color(0xFFFFA91A));
    } else {
      final theme = Theme.of(context);
      icon = const Icon(Icons.circle,
          size: 50, color: Color.fromARGB(255, 255, 0, 0));
    }

    return ClipOval(
      child: Material(
        child: InkWell(
          child: SizedBox(
            width: 60,
            height: 60,
            child: icon,
          ),
          onTap: () {
            print(_recordState);
            if (_recordState != RecordState.stop) {
              _stop();
            } else {
              setState(() {
                _waiting = true;
              });
              _start();
            }
          },
        ),
      ),
    );
  }
}
