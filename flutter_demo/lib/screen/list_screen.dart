import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_demo/content/contents.dart';
import 'package:flutter_demo/widget/pull_to_refresh.dart';

class ImageListWidget extends StatefulWidget {
  @override
  State<ImageListWidget> createState() => ImageListWidgetState();
}

class ImageListWidgetState extends State<ImageListWidget> {
  @override
  void initState() {
    super.initState();
    _onRefresh(false);
  }

  @override
  Widget build(BuildContext context) {
    if (ContentsManager().hasContent()) {
      return PullToRefreshWidget(
        child: ListView.builder(

            scrollDirection: Axis.vertical,
            itemCount: ContentsManager().size(),
            itemBuilder: (BuildContext context, int index) => Item(index)),
        onRefresh: () {
          return _onRefresh(false);
        },
        onLoadMore: () {
          return _onRefresh(true);
        },
      );
    } else {
      return Center(child: Text('No Content'),);
    }
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
