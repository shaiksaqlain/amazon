// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<List<File>> picImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (files != null && files.files.isNotEmpty) {
      for (var i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return images;
}
