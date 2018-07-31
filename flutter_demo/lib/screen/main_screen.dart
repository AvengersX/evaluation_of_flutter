import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/screen/list_screen.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/test.jpg'),
        new RaisedButton(
          child: new Text("Show Images"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImageListWidget()),
            );
          },
        ),
      ],
    ));
  }
}
