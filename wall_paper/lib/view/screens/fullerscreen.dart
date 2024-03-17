import 'package:flutter/material.dart';

class FullerScreen extends StatefulWidget {
  final String image1;

  FullerScreen({super.key, required this.image1});

  @override
  State<FullerScreen> createState() => _FullerScreenState();
}

class _FullerScreenState extends State<FullerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(widget.image1))),
      ),
    );
  }
}
