import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_demo/content/contents.dart';
import 'package:flutter_demo/widget/pull_to_refresh.dart';

class ImageListWidget extends StatefulWidget {
  @override
  State<ImageListWidget> createState() => ImageListWidgetState();
}

class ImageListWidgetState extends State<ImageListWidget> {
  double _imageWidth;
  double _imageHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _imageWidth = size.width;
    _imageHeight = size.height / 2;
    print(_imageWidth);
    print(_imageHeight);
    List<Widget> widgets = [];
    for (int i = 1; i < 63; i++) {
      i % 2 == 0
          ? widgets.add(Text('HelloWorld $i'))
          : widgets.add(Image.asset(
              'images/p$i.jpg',
              fit: BoxFit.fill,
              width: _imageWidth,
              height: _imageHeight,
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
