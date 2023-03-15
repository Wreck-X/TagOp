import 'package:flutter/material.dart';
import 'package:tagop/widgets/textfield.dart';
import 'package:tagop/models/file_Datamodel.dart';
import 'package:tagop/widgets/dropzonewid.dart';
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
                            ],
                          ),
                          SizedBox(width: 10),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 100,
                              color: Color.fromARGB(213, 83, 178, 255),
                              child: DropdownButton(
                                  value: dropdownvalue,
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                        value: items, child: Text(items));
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  }),
                            ),
                          ),
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
