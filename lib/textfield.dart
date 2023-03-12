import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  String entry;
  InputField(this.entry);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
          decoration: InputDecoration(
              hintText: entry,
              filled: true,
              fillColor: Color.fromARGB(255, 110, 168, 255))),
    );
  }
}
