import 'package:tagop/models/file_Datamodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

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
          onDrop: UploadedFile,
          onHover: () => setState(() => highlight = true),
          onLeave: () => setState(() => highlight = false),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 80,
                color: Colors.white,
              ),
              Text(
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
                  UploadedFile(events.first);
                },
                icon: Icon(Icons.search),
                label: Text(
                  'Choose File',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    primary: highlight
                        ? Colors.green.shade300
                        : Colors.blue.shade300,
                    shape: RoundedRectangleBorder()),
              )
            ],
          ),
        ),
      ],
    ));
  }

  Future UploadedFile(dynamic event) async {
    final name = event.name;
    final data = await controller.getFileData(event);
    final mime = await controller.getFileMIME(event);
    final byte = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
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
  }

  Widget buildDecoration({required Widget child}) {
    final colorBackground = highlight ? Colors.green : Colors.blue;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(10),
        child: child,
        color: colorBackground,
      ),
    );
  }
}
