import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  String entry;
  String query;
  InputField(this.query, this.entry);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 100,
            child: Text(query,
                style: TextStyle(color: Colors.white, fontSize: 18))),
        SizedBox(
          width: 250,
          height: 50,
          child: TextField(
              decoration: InputDecoration(
                  hintText: entry,
                  filled: true,
                  fillColor: Color.fromARGB(255, 110, 168, 255))),
        ),
      ],
    );
  }
}
