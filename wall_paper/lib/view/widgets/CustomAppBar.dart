import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wall_paper/view/screens/ColorProvider.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);

    return Container(
      color: Colors.transparent,
      child: RichText(
          text: TextSpan(
              text: "Wall",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: colorProvider.titlePrimary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              children: [
            TextSpan(
                text: "palette",
                style: TextStyle(
                    color: colorProvider.titleSec,
                    fontSize: 25,
                    fontWeight: FontWeight.bold))
          ])),
    );
  }
}
