import 'package:flutter/material.dart';
import 'package:tagop/pages/tags.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(children: [
        SizedBox(
          height: height * 0.9,
          width: width * 0.5,
          child: Placeholder(),
        ),
        SizedBox(
          height: height * 0.9,
          width: width * 0.5,
          child: TagsPage(),
        )
      ]),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 46, 103, 177),
        title: Text(
          "Search here",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
