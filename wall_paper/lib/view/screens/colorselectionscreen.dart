import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wall_paper/view/screens/ColorProvider.dart';
import 'package:wall_paper/view/widgets/CustomAppBar.dart';

class ColorSelectionScreen extends StatefulWidget {
  @override
  _ColorSelectionScreenState createState() => _ColorSelectionScreenState();
}

class _ColorSelectionScreenState extends State<ColorSelectionScreen> {
  // ColorProvider colorProvider  = Provider.of<ColorProvider>(context);;

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      backgroundColor: colorProvider.redPrimary,
      appBar: AppBar(
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: CustomAppBar(),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildColorContainer(context, ColorPalette.palette1, 'images/p1.png'),
          _buildColorContainer(context, ColorPalette.palette2, 'images/p2.png'),
          _buildColorContainer(context, ColorPalette.palette3, 'images/p3.png'),
          _buildColorContainer(context, ColorPalette.palette4, 'images/p4.png'),
          _buildColorContainer(context, ColorPalette.palette5, 'images/p5.png'),
        ],
      ),
    );
  }

  Widget _buildColorContainer(
      BuildContext context, ColorPalette palette, String imageUrl) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              width: 400,
              height: 400,
              //color: palette.primaryColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          _buildCheckbox(context, palette),
        ],
      ),
    );
  }

  Widget _buildCheckbox(BuildContext context, ColorPalette palette) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Palette ${palette.index + 1}',
          style: TextStyle(
              color: colorProvider.titleSec,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        Checkbox(
          checkColor: colorProvider.titlePrimary,
          tristate: true,
          value: colorProvider.selectedPalette == palette,
          onChanged: (value) {
            print(palette);
            setState(() {
              if (value == true) {
                colorProvider.setColorPalette(palette);
              }
            });
          },
        ),
      ],
    );
  }
}
