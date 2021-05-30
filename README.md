# image_cacheing


image_cacheing is an image caching package. It is currently tested for Android applications.

ImageCacheing widget takes url as a param. url params take in String url for the image url.
```dart
ImageCacheing(url: "Image URL"),
```

ImageCacheing widget also takes param named loadingWidget. This take widget it will show when the image is loading to be cache to your system.
```dart
ImageCacheing(
    url: global.imageLoadingUrl,
    loadingWidget: Center(child: CircularProgressIndicator())),
```

ImageCacheing widget also takes param named errorWidget. This take widget it will show when an error occurred in the widget. For example, giving in a valid URL.

```dart
ImageCacheing(
    url: global.imageErrorUrl,
    errorWidget: Center(child: Icon(Icons.warning)))
```