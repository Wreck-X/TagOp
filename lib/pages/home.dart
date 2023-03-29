import 'tags.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tagop/widgets/textfield.dart';
import 'package:tagop/widgets/dropzonewid.dart';
import 'package:tagop/models/file_Datamodel.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tagop/widgets/droppedfilewidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//* Authentication
class GoogleAuthClient extends http.BaseClient {
  
  final Map<String, String> _headers;

  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);
  
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }

}

class _MyHomePageState extends State<MyHomePage> {
  
  String dropdownvalue = "Item1";
  File_Data_Model? file;
  var items = ["Item1", "Item2", "Item3"];

  //* Sign In Function
  Future<void> signIn() async {
    
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        drive.DriveApi.driveFileScope,
      ],
    );

    try {
      final account = await googleSignIn.signIn();

      // Canceled sign in:
      if (account == null) {
        return;
      }

      // God knows how authentication works
      final authHeaders = await account.authHeaders;
      final authenticateClient = GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(authenticateClient);

      // Something something upload url something get image from url
      // except it does not work
      final file = drive.File()
        ..name = "Test.jpg"
        ..parents = ['1vIIBPSuE-87hobOBvtzr9kbFmsNkVawW'];
      
      final fileUrl = "http://localhost:40613/de2462a6-256b-4d90-a344-f3e0771683e6";
      //! Error here
      final response = await http.get(Uri.parse(fileUrl));
      
      print("sisds");
      
      final stream = http.ByteStream.fromBytes(response.bodyBytes);
      final media = drive.Media(stream, response.contentLength);

      final uploadedFile = await driveApi.files.create(file, uploadMedia: media);

      if (uploadedFile != null) {
        print('File uploaded successfully!');
      } else {
        print('Error uploading file');
      }
    
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
                                onPressed: signIn,
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
