import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Helpers {
  static void hideKeyboard(BuildContext ct) {
    FocusScope.of(ct).unfocus();
  }

  void copyText(String text, {VoidCallback? onDone}) {
    Clipboard.setData(ClipboardData(text: text))
        .then((value) => onDone?.call());
  }

  static int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    int verCell0 = versionCells.isEmpty ? 0 : versionCells[0];
    int verCell1 = versionCells.length < 2 ? 0 : versionCells[1];
    int verCell2 = versionCells.length < 3 ? 0 : versionCells[2];
    return verCell0 * 10000 + verCell1 * 1000 + verCell2;
  }

  static void launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      compute(launchUrlString, url);
    } else {
      throw ArgumentError('Could not launch $url');
    }
  }

  static String base64Encode(String credentials) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);
    return encoded;
  }

  static String base64Decode(String encode) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String decoded = stringToBase64.decode(encode);
    return decoded;
  }

  static Future<File> imgFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    return File(pickedFile!.path);
  }

  static Future<File> imgFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return File(pickedFile!.path);
  }
}
