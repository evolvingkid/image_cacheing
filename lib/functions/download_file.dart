import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

Future<File> downloadFile({
  required String url,
  required String fileName,
  required String fileExtension,
}) async {
  HttpClient _httpClient = new HttpClient();

  // * choosing where to add image
  final _appDocumnetDirectory = await getApplicationDocumentsDirectory();
  final String _filepath =
      '${_appDocumnetDirectory.path}/$fileName$fileExtension';

  // * acessing Image
  HttpClientRequest _request = await _httpClient.getUrl(Uri.parse(url));
  HttpClientResponse _response = await _request.close();
  Uint8List _bytes = await consolidateHttpClientResponseBytes(_response);

  File file = new File(_filepath);
  await file.writeAsBytes(_bytes);
  return file;
}
