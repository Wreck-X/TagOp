// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final textfield = TextEditingController();

  void clearText() {
    textfield.clear();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 131, 253, 239)),
      home: Scaffold(
          appBar: AppBar(
            title: Text("TagOP"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 61, 145, 255),
            shadowColor: Color.fromARGB(0, 0, 0, 0),
          ),
          body: Row(
            children: [
              Text("Patient Name -"),
              SizedBox(
                width: 250,
                child: TextField(
                    decoration: InputDecoration(
                        hintText: "Enter Patient Name",
                        filled: true,
                        fillColor: Color.fromARGB(255, 110, 238, 255))),
              )
            ],
          )),
    );
  }
}
