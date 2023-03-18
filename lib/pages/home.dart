import 'package:flutter/material.dart';
import 'package:tagop/widgets/droppedfilewidget.dart';
import 'package:tagop/widgets/textfield.dart';
import 'package:tagop/models/file_Datamodel.dart';
import 'package:tagop/widgets/dropzonewid.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'tags.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;

  final http.Client _client = new http.Client();

  GoogleAuthClient(this._headers);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownvalue = "Item1";
  File_Data_Model? file;
  var items = ["Item1", "Item2", "Item3"];

  //* Sign In Function
  Future<void> _Sign() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        drive.DriveApi.driveFileScope,
      ],
    );

    try {
      final account = await googleSignIn.signIn();

      if (account == null) {
        return;
      }

      final authHeaders = await account.authHeaders;
      final authenticateClient = GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(authenticateClient);

      final Stream<List<int>> mediaStream =
          Future.value([104, 105]).asStream().asBroadcastStream();

      var media = new drive.Media(mediaStream, 2);
      var driveFile = new drive.File();
      driveFile.name = "hello_world.jpg";

      final result = await driveApi.files.create(driveFile, uploadMedia: media);

      print("Upload result: $result");
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
                                child: const Text("Sign In"),
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
                                        () {}, // TODO Add upload functionality
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
