
import 'package:tagop/models/file_Datamodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tagop/models/file_Datamodel.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';


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


class DropZoneWidget extends StatefulWidget {
  
  final ValueChanged<File_Data_Model> onDroppedFile;
  const DropZoneWidget({Key? key, required this.onDroppedFile})
      : super(key: key);
  
  @override
  _DropZoneWidgetState createState() => _DropZoneWidgetState();

}

class _DropZoneWidgetState extends State<DropZoneWidget> {
  
  late DropzoneViewController controller;
  bool highlight = false;

  @override
  Widget build(BuildContext context) {
    return buildDecoration(
            child: Stack(
              children: [
                DropzoneView(
                  onCreated: (controller) => this.controller = controller,
                  onDrop: uploadedFile,
                  onHover: () => setState(() => highlight = true),
                  onLeave: () => setState(() => highlight = false),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_upload_outlined,
                        size: 80,
                        color: Colors.white,
                      ),
                      const Text(
                        'Drop Files Here',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final events = await controller.pickFiles();
                          if (events.isEmpty) return;
                          uploadedFile(events.first);
                        },
                        icon: const Icon(Icons.search),
                        label: const Text(
                          'Choose File',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          backgroundColor: highlight? Colors.green.shade300:Colors.blue.shade300,
                          shape: const RoundedRectangleBorder()),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future uploadedFile(dynamic event) async {
    
    final name = event.name;
    final data = await controller.getFileData(event);
    final mime = await controller.getFileMIME(event);
    final byte = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);


    //* DEBUG

    print('Name : $name');
    print('Mime: $mime');
    print('Size : ${byte / (1024 * 1024)}');
    print('URL: $url');

    final droppedFile =
      File_Data_Model(name: name, mime: mime, bytes: byte, url: url);

    widget.onDroppedFile(droppedFile);
    
    setState(() {
      highlight = false;
    });

    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        drive.DriveApi.driveFileScope,
      ],
    );

    try {
      
      final account = await googleSignIn.signIn();

      //TODO Canceled sign in: Should probably do something
      if (account == null) {
        return;
      }

      // God knows how authentication works
      final authHeaders = await account.authHeaders;
      final authenticateClient = GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(authenticateClient);

      final file = drive.File()
        ..name = "Test.jpg" // File name
        ..parents = ['1vIIBPSuE-87hobOBvtzr9kbFmsNkVawW']; // Parent Folder
      
      final response = await http.get(Uri.parse(url));
      final stream = http.ByteStream.fromBytes(response.bodyBytes);
      final media = drive.Media(stream, response.contentLength);
      await driveApi.files.create(file, uploadMedia: media);

      print("File uploaded.");

    //TODO Do something here as well possibly
    } catch (error) {
      print(error);
    }
    
  }

  Widget buildDecoration({required Widget child}) {
    final colorBackground = highlight ? Colors.green : Colors.blue;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: colorBackground,
        child: child,
      ),
    );
  }
  
}
