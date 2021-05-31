import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';
import 'package:convert/convert.dart';

// create a unique file name for each files.
// so that their will be bo deplication of code in the storage
String generateFileName(String data, String ext) {
  return hex.encode(crypto.md5.convert(Utf8Encoder().convert(data)).bytes) +
      ext;
}
