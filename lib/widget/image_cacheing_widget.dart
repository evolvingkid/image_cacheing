import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
// * custom function file have the all exported file for functions used in this package.
import '../functions/custom_functions.dart';

class ImageCacheing extends StatefulWidget {
  final String url;
  final String ext;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final double scale;
  final AlignmentGeometry alignment;
  final double? width;
  final double? height;
  final FilterQuality filterQuality;
  final BoxFit? fit;

  ImageCacheing({
    required this.url,
    this.ext = '.png',
    this.loadingWidget,
    this.errorWidget,
    this.scale = 1.0,
    this.alignment = Alignment.center,
    this.height,
    this.width,
    this.filterQuality = FilterQuality.low,
    this.fit,
  });

  @override
  _ImageCacheingState createState() => _ImageCacheingState();
}

class _ImageCacheingState extends State<ImageCacheing> {
  File img = File('');
  bool _isLoading = true;
  bool _errorOccured = false;

  void _getImage() async {
    if (kIsWeb) return null;
    try {
      // * try to acess Image
      _errorOccured = false;
      String _imgPath = generateFileName(widget.url, widget.ext);
      File _imageFile = await fileFromDocsDir(_imgPath + widget.ext);

      // ? trying check Image
      if (await _imageFile.exists()) {
        if (!mounted) return;
        _isLoading = false;
        setState(() => img = _imageFile);
        return null;
      }

      // ? trying to download image and cache it
      _imageFile = await downloadFile(
          fileExtension: widget.ext, fileName: _imgPath, url: widget.url);

      // ! mounted is check before every setstate to check if the widget is still their
      if (!mounted) return;
      _isLoading = false;
      setState(() => img = _imageFile);
    } catch (e) {
      setState(() => _errorOccured = true);
    }
  }

  @override
  void initState() {
    _getImage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ImageCacheing oldWidget) {
    _getImage();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return imageHandler(image: img);
  }

  Widget imageHandler({required File image}) {
    // ? give error handle for the web platform
    if (kIsWeb) {
      return networkImage();
    }

    // ? this is work when user is  initlize error Widgets
    if (widget.errorWidget != null) {
      return _errorOccured ? widget.errorWidget! : const SizedBox();
    }

    // ? this will work when user is initlize loading widgets
    if (widget.loadingWidget != null) {
      return _isLoading ? widget.loadingWidget! : fileImage(image);
    }

    // ? this will work  when image is cached and needed showen
    return _isLoading ? const SizedBox() : fileImage(image);
  }

  Image fileImage(File image) {
    // file image shows for the non - web platform
    return Image.file(
      image,
      scale: widget.scale,
      alignment: widget.alignment,
      width: widget.width,
      height: widget.height,
      filterQuality: widget.filterQuality,
      fit: widget.fit,
    );
  }

  Image networkImage() {
    // network image will show for web platform
    return Image.network(
      widget.url,
      scale: widget.scale,
      alignment: widget.alignment,
      width: widget.width,
      height: widget.height,
      filterQuality: widget.filterQuality,
      fit: widget.fit,
      errorBuilder: (ctx, obj, _) =>
          widget.errorWidget == null ? const SizedBox() : widget.errorWidget!,
    );
  }
}
