import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<File> fileFromDocsDir(String filename) async {
  final appDocDir = await getApplicationDocumentsDirectory();
  String pathName = p.join(appDocDir.path, filename);
  return File(pathName);
}
