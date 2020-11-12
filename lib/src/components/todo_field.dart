import 'package:flutter/material.dart';

TextField buildTextField(
    String title, IconData icon, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: title,
      labelText: title,
      prefixIcon: Icon(icon),
      border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.teal)),
    ),
  );
}
