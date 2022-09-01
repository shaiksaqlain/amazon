import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.maxLines = 1})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: widget.hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38))),
      maxLines: widget.maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }
        return null;
      },
    );
  }
}
