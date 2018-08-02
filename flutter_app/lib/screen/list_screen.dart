import 'package:flutter/widgets.dart';

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
}
