import 'package:flutter/material.dart';
import 'package:image_cacheing/image_cacheing.dart';
import './global/vars.dart' as global;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // * normal Image cache
            Container(child: ImageCacheing(url: global.imageUrl)),
            // * image cache with loading
            Container(
                child: ImageCacheing(
                    url: global.imageLoadingUrl,
                    loadingWidget: Center(child: CircularProgressIndicator()))),
            // * image cache with warning
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
