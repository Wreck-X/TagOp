import 'package:flutter/material.dart';
import 'package:tagop/pages/home.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "LOGIN",
            style: TextStyle(fontSize: 50),
          ),
          Column(
            children: [
              const Text("Username"),
              Container(
                  width: 200,
                  child: const SizedBox(
                    child: TextField(
                        decoration: InputDecoration(
                            filled: true, fillColor: Colors.white)),
                  )),
              const Text("Password"),
              Container(
                  width: 200,
                  child: const SizedBox(
                    child: TextField(
                        decoration: InputDecoration(
                            filled: true, fillColor: Colors.white)),
                  ))
            ],
          ),
          Container(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const MyHomePage()));
                  },
                  child: const Text("Login")))
        ]),
      ),
    );
  }
}
