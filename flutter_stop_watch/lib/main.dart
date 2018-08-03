import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
            // counter didn't reset back to zero; the application is not restarted.
            ),
        home: Container(
          color: Colors.white,
          child: Center(
            child: MyStopWatch(),
          ),
        ));
  }
}

class MyStopWatch extends StatefulWidget {
  @override
  State<MyStopWatch> createState() => MyStopWatchState();
}

class MyStopWatchState extends State<MyStopWatch> {
  final _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );
  final _offset = Offset(0.0, 0.0);

  Timer _timer;

  @override
  void initState() {
    super.initState();
    setText('');
    _timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        DateTime now = DateTime.now();
        setText(
            '${now.second.toString().padLeft(2, '0')} ${(now.millisecond ~/ 10).toString().padLeft(2, '0')}');
      });
    });
  }

  setText(String text) {
    _textPainter.text = TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 120.0,
      ),
      text: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(330.0, 120.0),
      painter: StopWatchPainter(_textPainter, _offset),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _timer = null;
  }
}

class StopWatchPainter extends CustomPainter {
  final TextPainter _textPainter;
  final _offset;

  StopWatchPainter(this._textPainter, this._offset);

  @override
  void paint(Canvas canvas, Size size) {
    _textPainter.layout();
    _textPainter.paint(canvas, _offset);
  }

  @override
  bool shouldRepaint(StopWatchPainter oldDelegate) {
    return true;
  }
}
