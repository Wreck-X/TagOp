import 'package:flutter/material.dart';
import 'package:tagop/widgets/buttons.dart';

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    switch (selectedindex) {
      case 0:
        page = Tag1();
        break;
      case 1:
        page = Tag2();
        break;
      default:
        throw UnimplementedError('no widget');
    }

    return Container(
      child: Row(children: [
        SafeArea(
            child: NavigationRail(
          backgroundColor: Colors.blue.shade100,
          extended: height * width >= 900,
          destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.circle),
              label: Text("Something"),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.circle),
              label: Text("Somethingelse"),
            )
          ],
          selectedIndex: selectedindex,
          onDestinationSelected: (value) => {
            setState(
              () => {selectedindex = value},
            )
          },
        )),
        SizedBox(width: 10),
        Container(
          height: height,
          width: width * 0.34,
          child: page,
        )
      ]),
    );
  }
}

class Tag1 extends StatelessWidget {
  Tag1({super.key});
  var tags = [for (var i = 1; i <= 10; i++) "tag$i"];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: tags.map((tags) => Buttons(tags)).toList(),
    );
  }
}

class Tag2 extends StatelessWidget {
  Tag2({super.key});
  var tags = [for (var i = 1; i <= 10; i++) "tag$i"];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: tags.map((tags) => Buttons(tags)).toList(),
    );
    ;
  }
}
