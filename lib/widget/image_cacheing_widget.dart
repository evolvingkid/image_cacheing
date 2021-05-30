import 'dart:io';
import 'package:flutter/material.dart';

import '../functions/custom_functions.dart';

class ImageCacheing extends StatefulWidget {
  final String url;
  final String ext;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  ImageCacheing(
      {required this.url,
      this.ext = '.png',
      this.loadingWidget,
      this.errorWidget});

  @override
  _ImageCacheingState createState() => _ImageCacheingState();
}

class _ImageCacheingState extends State<ImageCacheing> {
  File img = File('');
  bool _isLoading = true;
  bool _errorOccured = false;

  void _getImage() async {
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
    if (widget.errorWidget != null) {
      return _errorOccured ? widget.errorWidget! : const SizedBox();
    }

    if (widget.loadingWidget != null) {
      return _isLoading ? widget.loadingWidget! : Image.file(image);
    }

    return _isLoading ? const SizedBox() : Image.file(image);
  }
}
