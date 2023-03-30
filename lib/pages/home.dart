import 'package:flutter/material.dart';
import 'package:tagop/widgets/droppedfilewidget.dart';
import 'package:tagop/widgets/textfield.dart';
import 'package:tagop/models/file_Datamodel.dart';
import 'package:tagop/widgets/dropzonewid.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'search.dart';
import 'tags.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownvalue = "Item1";
  File_Data_Model? file;
  var items = ["Item1", "Item2", "Item3"];

  //* Sign In Function
  Future<void> _Sign() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        // TODO Add Drive scopes
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "TagOP",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 46, 103, 177),
          shadowColor: const Color.fromARGB(0, 0, 0, 0),
        ),
        body: Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Row(children: [
                          Column(
                            children: [
                              InputField("Name -", "Patient Name"),
                              const SizedBox(height: 5),
                              InputField("Age -", "Patient Age "),
                              const SizedBox(height: 5),
                              InputField("Id -", "Patient Id"),
                              TextButton(
                                onPressed: _Sign,
                                child: const Text("Sign In"),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          DroppedFileWidget(file: file),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          213, 83, 178, 255),
                                      textStyle: const TextStyle(
                                          color: Colors
                                              .white)), // TODO Add upload functionality
                                  child: const Text("Upload"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SearchPage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          213, 83, 178, 255),
                                      textStyle: const TextStyle(
                                          color: Colors
                                              .white)), // TODO Add upload functionality
                                  child: const Text("Search"),
                                ),
                              ),
                            ],
                          )
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.7,
                              width: width * 0.5,
                              child: DropZoneWidget(
                                  onDroppedFile: (file) =>
                                      setState(() => this.file = file)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const TagsPage()
              ],
            )));
  }
}
