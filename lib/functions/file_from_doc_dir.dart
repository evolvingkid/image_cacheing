import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// ? this function help get previous file from the storage
// AKA cache file from the storage.
Future<File> fileFromDocsDir(String filename) async {
  final appDocDir = await getApplicationDocumentsDirectory();
  String pathName = p.join(appDocDir.path, filename);
  return File(pathName);
}
