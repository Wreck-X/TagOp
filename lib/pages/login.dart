import 'package:amplify_storage_s3_dart/amplify_storage_s3_dart.dart';
import 'package:flutter/material.dart';
import 'package:tagop/pages/home.dart';
import 'package:tagop/amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  @override
  initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    // Add any Amplify plugins you want to use
    final authPlugin = AmplifyAuthCognito();
    final storage = AmplifyStorageS3Dart();
    await Amplify.addPlugins([authPlugin, storage]);

    // You can use addPlugins if you are going to be adding multiple plugins
    // await Amplify.addPlugins([authPlugin, analyticsPlugin]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: height,
      child: Material(
        color: const Color.fromRGBO(255, 90, 90, 1),
        child: Stack(
          children: <Widget>[
            Center(
              child: Positioned(
                // White Box
                child: Container(
                  width: 550,
                  height: 552,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 50)
                    ],
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border.all(
                      color: const Color.fromARGB(255, 138, 48, 48),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: Positioned(
                // Username Input
                child: SizedBox(
                  width: 401,
                  height: 71,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(236, 236, 236, 1),
                      hintText: 'Enter username',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // Password Input
              top: height / 2 + 61.5,
              left: width / 2 - 200.5,
              child: const SizedBox(
                width: 401,
                height: 71,
                child: TextField(
                  obscureText: true, // hides the password characters
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(236, 236, 236, 1),
                    hintText: 'Enter password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height / 2 + 125 + 35.5,
              left: width / 2 - 131.5,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const MyHomePage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 232, 232, 1),
                  foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    side: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                  ),
                ),
                child: const SizedBox(
                  width: 163,
                  height: 39,
                  child: Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: height / 2 + 35.5 + 103,
              left: width / 2 - 124,
              child: const DefaultTextStyle(
                style: TextStyle(
                  color: Color.fromRGBO(255, 90, 90, 1),
                  fontFamily: 'ReadexPro',
                  fontSize: 80,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
                child: Center(
                  child: Text('TagOp', textAlign: TextAlign.center),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
