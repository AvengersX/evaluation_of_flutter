import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as HttpClient;

class ContentsManager {
  static ContentsManager _instance;

  List<String> _contents = [];
  List<String> get contents => List.from(_contents, growable: false);

  Future<bool> _curFetchingFuture;
  int curPageNum;

  factory ContentsManager() => _instance ??= ContentsManager._internal();

  ContentsManager._internal();

  Future<bool> loadMore() {
    if (curPageNum == null || curPageNum < 0) {
      return refresh();
    }

    int startId = curPageNum + 1;
    return _curFetchingFuture ??= _fetch(startId).then((fetchResult) {
      _curFetchingFuture = null;
      _contents.addAll(fetchResult);
      curPageNum++;
      return true;
    }).catchError(() {
      return false;
    });
  }

  Future<bool> refresh() {
    return _curFetchingFuture ??= _fetch(0).then((fetchResult) {
      _curFetchingFuture = null;
      _contents.clear();
      _contents.addAll(fetchResult);
      curPageNum = 0;
      return true;
    }).catchError(() {
      return false;
    });
  }

  bool isLoading() => _curFetchingFuture != null;

  bool hasContent() => _contents.isNotEmpty;

  int size() => _contents.length;

  String contentAt(int index) =>
      index >= _contents.length ? null : _contents[index];

  Future<List<String>> _fetch(int startId) async {
    List<String> result = [];
    try {
      String url =
          'http://image.baidu.com/channel/listjson?pn=$startId&rn=30&tag1=%E5%AE%A0%E7%89%A9&tag2=%E5%85%A8%E9%83%A8&ie=utf8';
      HttpClient.Response response = await HttpClient.get(url);

      Map map = json.decode(response.body);
      List array = map['data'];
      if (array != null) {
        for (var item in array) {
          result.add(item['image_url']);
        }
        result.removeWhere((value) => (value == null || value == ''));
      }
    } catch (e, s) {}
    return result;
  }
}
