// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'models/file_Datamodel.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:tagop/widgets/dropzonewid.dart';
import 'widgets/textfield.dart';
import 'pages/home.dart';
import 'pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color.fromARGB(169, 84, 154, 235),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 89, 219, 228)),
      ),
      home: MyLoginPage(),
    );
  }
}
