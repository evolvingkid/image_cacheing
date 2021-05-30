import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';
import 'package:convert/convert.dart';

String generateFileName(String data, String ext) {
  return hex.encode(crypto.md5.convert(Utf8Encoder().convert(data)).bytes) +
      ext;
}
