import 'dart:io';
import 'package:tagop/models/file_Datamodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'dart:html' as html;
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:amplify_storage_s3_dart/amplify_storage_s3_dart.dart';
import 'package:aws_common/web.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
//* Authentication

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
                      backgroundColor: highlight
                          ? Colors.green.shade300
                          : Colors.blue.shade300,
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
    var url = await controller.createFileUrl(event);
    print('Name : $name');
    print('Mime: $mime');
    print('Size : ${byte / (1024 * 1024)}');
    print('URL: $url');

    final droppedFile = File_Data_Model(
        name: name, mime: mime, bytes: byte, url: url, data: data);
    widget.onDroppedFile(droppedFile);

    setState(() {
      highlight = false;
    });

    // var file = File.fromRawPath(data);
    // final awsFile = AWSFilePlatform.fromFile(file);
    // try {
    //   final uploadResult = await Amplify.Storage.uploadFile(
    //     localFile: awsFile,
    //     key: 'upload/file.png',
    //   ).result;
    //   safePrint('Uploaded file: ${uploadResult.uploadedItem.key}');
    // } on StorageException catch (e) {
    //   safePrint(e.message);
    //   rethrow;
    //

    var resulturl = url.substring(5);
    final response = await http.get(Uri.parse(url));
    final stream = http.ByteStream.fromBytes(response.bodyBytes);
    AWSFile file = AWSFile.fromStream(stream, size: byte);
    try {
      final uploadResult = await Amplify.Storage.uploadFile(
        localFile: file,
        key: 'upload/file.png',
      ).result;
      safePrint('Uploaded file: ${uploadResult.uploadedItem.key}');
    } on StorageException catch (e) {
      safePrint(e.message);
      rethrow;
    }

    // Dio dio = new Dio();
    // var bucketName = 'medicalimagesbucket';
    // final uri =
    //     Uri.parse('https://medicalimagesbucket.s3.amazonaws.com/test.jpeg');
    // var request = new http.MultipartRequest('PUT', uri);
    // final httpImage = await http.MultipartFile.fromPath('files.images', url,
    //     contentType: MediaType.parse(mime), filename: name);
    // request.files.add(httpImage);
    // final response = await request.send();
    // print(response);
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
