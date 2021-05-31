import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

//? this function  is used to download the file
Future<File> downloadFile({
  required String url,
  required String fileName,
  required String fileExtension,
}) async {
  try {
    //  we are using http client dart build in download system for caching the data
    HttpClient _httpClient = new HttpClient();

    // * choosing where to add image
    final _appDocumnetDirectory = await getApplicationDocumentsDirectory();
    // ? the file path where all the image that needed to cache are saved
    final String _filepath =
        '${_appDocumnetDirectory.path}/$fileName$fileExtension';

    // * acessing Image from the servers
    HttpClientRequest _request = await _httpClient.getUrl(Uri.parse(url));
    HttpClientResponse _response = await _request.close();
    Uint8List _bytes = await consolidateHttpClientResponseBytes(_response);

    // the downloaded file are save to var named file and resturn for further uses
    File file = new File(_filepath);
    await file.writeAsBytes(_bytes);
    return file;
  } catch (e) {
    throw e;
  }
}
