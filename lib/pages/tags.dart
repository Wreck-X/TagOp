import 'package:flutter/material.dart';

class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  var selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedindex) {
      case 0:
        page = Placeholder();
        break;
      case 1:
        page = Placeholder();
    }
    return Container(
        child: NavigationRail(
      extended: false,
      destinations: [
        NavigationRailDestination(
            icon: Icon(Icons.disc_full_rounded), label: Text("something")),
        NavigationRailDestination(
            icon: Icon(Icons.disc_full_rounded), label: Text("somethingelse"))
      ],
      selectedIndex: selectedindex,
      onDestinationSelected: (value) => {
        setState(
          () => {selectedindex = value},
        )
      },
    ));
  }
}
