import 'package:flutter/material.dart';
import 'package:image_cacheing/image_cacheing.dart';
import './global/vars.dart' as global;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

// ? example of the image cacheing
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // * normal Image cache
            Container(child: ImageCacheing(url: global.imageUrl)),
            // * image cache with loading
            // ? who can pass any type widget to show on loading widgets
            Container(
                child: ImageCacheing(
                    url: global.imageLoadingUrl,
                    loadingWidget: Center(child: CircularProgressIndicator()))),
            // * image cache with warning
            // ? who can pass any type widget to show on error widgets
            Container(
                child: ImageCacheing(
                    url: global.imageErrorUrl,
                    errorWidget: Center(child: Icon(Icons.warning)))),
          ],
        ),
      ),
    );
  }
}
