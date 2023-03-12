// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'textfield.dart';

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
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 35, 40, 100)),
      home: Scaffold(
          appBar: AppBar(
            title: Text("TagOP"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 46, 103, 177),
            shadowColor: Color.fromARGB(0, 0, 0, 0),
          ),
          body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                InputField("Patient Name"),
                SizedBox(height: 10),
                InputField("Patient Id"),
              ],
            ),
          )),
    );
  }
}
