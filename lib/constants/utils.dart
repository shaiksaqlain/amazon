import 'dart:io';

import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

picImages() {
  List<File> images = [];

  try {} catch (e) {
    debugPrint(e.toString());
  }
}
