import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef Future<Null> RefreshCallback();

class PullToRefreshWidget extends StatefulWidget {
  const PullToRefreshWidget(
      {@required this.child,
      @required this.onRefresh,
      @required this.onLoadMore})
      : assert(child != null),
        assert(onRefresh != null),
        assert(onLoadMore != null);

  final Widget child;
  final RefreshCallback onRefresh;
  final RefreshCallback onLoadMore;

  @override
  _PullToRefreshState createState() {
    return _PullToRefreshState();
  }
}

const kDragOffset = 40.0;

class _PullToRefreshState extends State<PullToRefreshWidget> {
  static const load_state_idle = 0;
  static const load_state_more = 1;
  static const load_state_refresh = 2;

  int _loadState = load_state_idle;
  double _dragOffset;

  @override
  Widget build(BuildContext context) {
//    final Widget child = NotificationListener<ScrollNotification>(
//      onNotification: _handleScrollNotification,
//      child: widget.child,
//    );

    return widget.child;
  }

  void handleResult(Future result) {
    if (result == null) return;
    result.whenComplete(() {
      if (mounted) {
        changeLoadState(load_state_idle);
      }
    });
  }

  void changeLoadState(int newLoadState) {
    setState(() {
      _loadState = newLoadState;
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      _dragOffset = 0.0;
    }

    if (notification is ScrollUpdateNotification && _dragOffset != null) {
      _dragOffset -= notification.scrollDelta;

      if (notification.metrics.extentBefore == 0.0 &&
          _dragOffset > kDragOffset) {
        // REFRESH
        if (_loadState == load_state_idle) {
          changeLoadState(load_state_refresh);
          handleResult(widget.onRefresh());
        }
      } else if (notification.metrics.extentAfter == 0.0 &&
          _dragOffset < -kDragOffset) {
        // LOAD MORE
        if (_loadState == load_state_idle) {
          changeLoadState(load_state_more);
          handleResult(widget.onLoadMore());
        }
      }
    }

    if (notification is ScrollEndNotification) {
      _dragOffset = null;
    }
    return false;
  }
}
