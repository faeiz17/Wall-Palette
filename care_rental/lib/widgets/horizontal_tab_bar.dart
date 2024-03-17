import 'package:flutter/material.dart';

class HorizontalTabBar extends StatelessWidget {
  const HorizontalTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelStyle: TextStyle(fontSize: 20),
      labelColor: Colors.yellow,
      unselectedLabelColor: Colors.grey,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2, color: Colors.yellow)),
      tabs: [
        "911",
        "Panamera",
        "Cayenne",
        "Macan",
        "Cayman",
        "Boxster",
        "Taycan",
        "918 Spyder",
      ]
          .map((e) => Text(
                e,
                style: TextStyle(
                  fontSize: 16,
                ),
              ))
          .toList(),
      isScrollable: true,
    );
  }
}
