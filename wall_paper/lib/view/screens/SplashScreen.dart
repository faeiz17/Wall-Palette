import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wall_paper/view/screens/home.dart';
import 'package:wall_paper/view/screens/wave.dart';
import 'package:wall_paper/view/screens/ColorProvider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delayed navigation to HomeScreen
    Future.delayed(Duration(seconds: 6), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Accessing the ColorProvider using Provider.of
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      body: Container(
        // Decorating the container with a gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorProvider.bgColorDark,
              colorProvider.bgColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // Using the WaveBackground widget
        child: WaveBackground(),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose resources here if needed
    super.dispose();
  }
}
