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
          Stack(children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 38, 118, 41),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('분석 결과',
                  style: TextStyle(fontSize: 50, fontFamily: 'DoH')),
              const SizedBox(
                height: 40,
              ),
              if (widget.sweetResult == 0)
                Image.asset('lib/images/bad_result.png',
                    width: 300, height: 300), // 이미지1
              // if (widget.sweetResult == 1)
              //   Image.asset('lib/images/soso_result.png',
              //       width: 300, height: 300), // 이미지2
              if (widget.sweetResult == 1)
                Image.asset('lib/images/good_result.png',
                    width: 300, height: 300), // 이미지3
              // 추가적인 조건이 있다면 여기에 계속해서 else if 문 추가
              // const Text('Play Recorded Audio'),
              const SizedBox(
                height: 40,
              ),
              // Text(widget.sweetResult.toString())
              if (widget.sweetResult == 0)
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '더 좋은 수박이 있을 거예요..\n',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 17, 0),
                            fontSize: 35,
                            fontFamily: 'DoH'), // 첫 번째 줄 텍스트 컬러
                      ),
                      TextSpan(
                        text: '맛 없는 수박으로 추정돼요',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'DoH',
                            fontSize: 35), // 두 번째 줄 텍스트 컬러
                      ),
                    ],
                  ),
                ),
              if (widget.sweetResult == 1)
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '맛있는 ',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 77, 65),
                            fontSize: 35,
                            fontFamily: 'DoH'), // 첫 번째 줄 텍스트 컬러
                      ),
                      TextSpan(
                        text: '수박이에요!🍉\n',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontFamily: 'DoH'), // 첫 번째 줄 텍스트 컬러
                      ),
                      TextSpan(
                        text: '감이 좋으시네요👍',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'DoH',
                            fontSize: 35), // 두 번째 줄 텍스트 컬러
                      ),
                    ],
                  ),
                ),
              if (widget.sweetResult == 3)
                Image.asset('lib/images/good_result.png',
                    width: 300, height: 300), // 이미지3
            ],
            //  ),
            //  ),
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
      ]),
    );
  }
}
