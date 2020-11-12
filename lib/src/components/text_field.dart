import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  TextEditingController controller;
  String hint;
  Field({this.controller, this.hint});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hint, border: InputBorder.none),
    );
  }
}
