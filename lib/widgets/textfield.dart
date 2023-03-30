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
                  fillColor: Colors.blue.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ))),
        ),
      ],
    );
  }
}
