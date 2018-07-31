import 'package:flutter/material.dart';
import 'package:flutter_demo/screen/list_screen.dart';
import 'package:flutter_demo/screen/main_screen.dart';

const page_home = '/';
const page_image_list = '/image_list';

void main() => runApp(FlutterDemo());

class FlutterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case page_home:
              return NonAnimationRoute(
                builder: (_) => MainPage(),
                settings: settings,
              );
            case page_image_list:
              return NonAnimationRoute(
                builder: (_) => ImageListWidget(),
                settings: settings,
              );
          }
          assert(false);
        });
  }
}

class NonAnimationRoute<T> extends MaterialPageRoute<T> {
  NonAnimationRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
