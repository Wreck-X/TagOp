// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'amplifyconfiguration.dart';

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
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 142, 115, 240)),
      ),
      home: MyLoginPage(),
    );
  }
}
