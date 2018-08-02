import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_demo/content/contents.dart';
import 'package:flutter_demo/widget/pull_to_refresh.dart';
import 'package:vector_math/vector_math.dart';

class ImageListWidget extends StatefulWidget {
  @override
  State<ImageListWidget> createState() => ImageListWidgetState();
}

class ImageListWidgetState extends State<ImageListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var imageWidth = size.width;
    var imageHeight = size.height / 2;
    var textHeight = size.height / 5;

    List<Widget> widgets = [];
    for (int i = 1; i < 63; i++) {
      i % 2 == 0
          ? widgets.add(Container(
              width: imageWidth,
              height: textHeight,
              child: Text('HelloWorld $i',
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 40.0,
                  )),
              color: Color(0XFFFFFFFF),
            ))
          : widgets.add(Image.asset(
              'images/p${i~/2 + 1}.jpg',
              fit: BoxFit.fill,
              width: imageWidth,
              height: imageHeight,
            ));
    }

    return ListView(
      children: widgets,
    );
  }

  Future<Null> _onRefresh(bool up) {
    Future<bool> future =
        up ? ContentsManager().loadMore() : ContentsManager().refresh();
    return future.then((success) {
      setState(() {});
      if (!success) {
        // Todo show Fail
      }
      return null;
    });
  }
}

class Item extends StatefulWidget {
  final index;

  Item(this.index);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    if (ContentsManager().contentAt(widget.index) == null) {
      return Container(width: 0.0, height: 0.0);
    }

    return Image.network(
      ContentsManager().contentAt(widget.index),
      fit: BoxFit.cover,
      height: 300.0,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
