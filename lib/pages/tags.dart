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
    return Container(
        child: NavigationRail(
      extended: false,
      destinations: [
        NavigationRailDestination(
            icon: Icon(Icons.disc_full_rounded), label: Text("something"))
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
