import 'package:flutter/material.dart';

class Sound extends StatefulWidget {
  const Sound({super.key});

  @override
  _Soundstate createState() => _Soundstate();
}

class _Soundstate extends State<Sound> {
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
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             HomeScreen()));
        },
      ),
      Center(
          child: Image.asset(
        'lib/images/watermelon_record.png',
        height: 350,
      )),
    ]));
  }
}
