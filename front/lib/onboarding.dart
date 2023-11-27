import 'package:flutter/material.dart';
import './sound.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  _OnBoardingstate createState() => _OnBoardingstate();
}

class _OnBoardingstate extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Home Page'),
        // ),
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
              height: 50,
            ),
            Text(
              '통통',
              style: TextStyle(
                  fontSize: 60, color: Color.fromARGB(255, 188, 28, 17)),
            ),
            Text('수박이 왔어요', style: TextStyle(fontSize: 60))
          ],
        ),
      ),
      Center(
          child: Image.asset(
        'lib/images/watermelon_main.png',
        height: 350,
      )),
      Padding(
        padding: const EdgeInsets.only(top: 700),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              color: const Color.fromARGB(255, 188, 28, 17),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Sound()));
                  },
                  child: const Text(
                    '통통 두드리기',
                    style: TextStyle(color: Colors.black),
                  )),
            ),
            const SizedBox(
              width: 70,
            ),
            Container(
              color: const Color.fromARGB(255, 188, 28, 17),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Sound()));
                  },
                  child: const Text(
                    '찰칵 사진찍기',
                    style: TextStyle(color: Colors.black),
                  )),
            )
          ],
        ),
      ),
    ]));
    // Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       const Text(
    //         'Hello, Flutter!',
    //         style: TextStyle(fontSize: 24),
    //       ),
    //       const SizedBox(height: 20),
    //       ElevatedButton(
    //         onPressed: () {
    //           // 버튼을 누를 때마다 화면 갱신
    //           setState(() {});
    //         },
    //         child: const Text('Press me!'),
    //       ),
    //     ],
    //   ),
    // ),
  }
}
