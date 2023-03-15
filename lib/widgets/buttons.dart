import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  String Buttonname;
  Buttons(this.Buttonname, {super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: width,
          child: ElevatedButton(onPressed: () {}, child: Text(Buttonname)),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
