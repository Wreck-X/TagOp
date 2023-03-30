import 'package:flutter/material.dart';
import 'package:tagop/models/file_Datamodel.dart';

class DroppedFileWidget extends StatelessWidget {
  final File_Data_Model? file;
  const DroppedFileWidget({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(child: buildImage(context)),
      ],
    );
  }

  Widget buildImage(BuildContext context) {
    if (file == null) return buildEmptyFile('No Selected File');

    print(file!.url);

    return Column(
      children: [
        if (file != null) buildFileDetail(file),
        Image.network(
          file!.url,
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          errorBuilder: (context, error, _) => buildEmptyFile('No Preview'),
        ),
      ],
    );
  }

  Widget buildEmptyFile(String text) {
    return Container(
      width: 120,
      height: 120,
      color: Colors.blue.shade300,
      child: Center(child: Text(text)),
    );
  }

  Widget buildFileDetail(File_Data_Model? file) {
    final style = TextStyle(fontSize: 20);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Preview',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
