import 'package:flutter/material.dart';
import 'package:tagop/widgets/droppedfilewidget.dart';
import 'package:tagop/widgets/textfield.dart';
import 'package:tagop/models/file_Datamodel.dart';
import 'package:tagop/widgets/dropzonewid.dart';
import 'tags.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownvalue = "Item1";
  File_Data_Model? file;
  var items = ["Item1", "Item2", "Item3"];

  Future<void> _Sign() async {
    GoogleSignIn _googleSignIn = GoogleSignIn.standard(scopes:
      [drive.DriveApi.driveScope]);
      await _googleSignIn.signIn();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "TagOP",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 46, 103, 177),
          shadowColor: Color.fromARGB(0, 0, 0, 0),
        ),
        body: Container(
            margin: EdgeInsets.all(10),
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
                              SizedBox(height: 5),
                              InputField("Age -", "Patient Age "),
                              SizedBox(height: 5),
                              InputField("Id -", "Patient Id"),
                              TextButton(
              onPressed: _Sign,
              child: Text("Sign In"),
            ),
                            ],
                          ),
                          SizedBox(width: 10),
                          DroppedFileWidget(file: file),
                          SizedBox(
                            width: 10,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                width: 100,
                                child: Container(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed:
                                        () {}, // TODO addUpload Functionality //
                                    child: Text("Upload"),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(213, 83, 178, 255),
                                        textStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                )),
                          )
                        ]),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
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
                TagsPage()
              ],
            )));
  }
}
