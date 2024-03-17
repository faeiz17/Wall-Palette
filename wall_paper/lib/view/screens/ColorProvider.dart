import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ColorPalette {
  palette1,
  palette2,
  palette3,
  palette4,
  palette5,
}

class ColorProvider extends ChangeNotifier {
  Color _titlePrimary = Color.fromARGB(255, 92, 131, 116);
  Color _titleSec = Color.fromARGB(255, 158, 200, 185);
  Color _bgColor = Color.fromARGB(255, 27, 66, 66);
  Color _bgColorDark = Color.fromARGB(255, 9, 38, 53);
  Color _redPrimary = Color.fromARGB(255, 209, 250, 234);

  static String get selectedPaletteKey => 'selected_palette';

  ColorPalette _selectedPalette = ColorPalette.palette1;

  Future<void> saveSelectedPaletteToFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('Saving palette to Firebase: ${_selectedPalette.index}');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'selected_palette': _selectedPalette.index});
    }
  }

  Future<void> loadSelectedPaletteFromFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (docSnapshot.exists) {
        final savedIndex = docSnapshot.get('selected_palette');
        print('Loaded palette index from Firebase: $savedIndex');
        if (savedIndex != null &&
            savedIndex >= 0 &&
            savedIndex < ColorPalette.values.length) {
          _selectedPalette = ColorPalette.values[savedIndex];
        } else {
          _selectedPalette = ColorPalette.palette1;
        }
      } else {
        _selectedPalette = ColorPalette.palette1;
      }

      setColorPalette(_selectedPalette);
    }
  }

  void setColorPalette(ColorPalette palette) {
    print('Setting color palette: $palette');
    _selectedPalette = palette;
    saveSelectedPaletteToFirebase(); // Save to Firebase

    switch (palette) {
      case ColorPalette.palette1:
        _setPalette1();
        break;
      case ColorPalette.palette2:
        _setPalette2();
        break;
      case ColorPalette.palette3:
        _setPalette3();
        break;
      case ColorPalette.palette4:
        _setPalette4();
        break;
      case ColorPalette.palette5:
        _setPalette5();
        break;
    }

    notifyListeners();
  }

  Color get titlePrimary => _titlePrimary;
  Color get titleSec => _titleSec;
  Color get bgColor => _bgColor;
  Color get bgColorDark => _bgColorDark;
  Color get redPrimary => _redPrimary;
  ColorPalette get selectedPalette => _selectedPalette;

  void _setPalette1() {
    _titlePrimary = Color.fromARGB(255, 117, 14, 33);
    _titleSec = Color.fromARGB(255, 227, 101, 29);
    _bgColor = Color.fromARGB(255, 190, 215, 84);
    _bgColorDark = Color.fromARGB(255, 50, 30, 30);
    _redPrimary = Color.fromARGB(255, 68, 0, 0);
  }

  void _setPalette2() {
    _titlePrimary = Color.fromARGB(255, 246, 250, 112);
    _titleSec = Color.fromARGB(255, 255, 0, 96);
    _bgColor = Color.fromARGB(255, 0, 223, 162);
    _bgColorDark = Color.fromARGB(255, 0, 121, 255);
    _redPrimary = Color.fromARGB(255, 225, 247, 248);
  }

  void _setPalette3() {
    _titlePrimary = Color.fromARGB(255, 82, 120, 83);
    _titleSec = Color.fromARGB(255, 238, 114, 20);
    _bgColor = Color.fromARGB(255, 249, 232, 217);
    _bgColorDark = Color.fromARGB(255, 247, 183, 135);
    _redPrimary = Color.fromARGB(255, 217, 255, 227);
  }

  void _setPalette4() {
    _titlePrimary = Color.fromARGB(255, 92, 131, 116);
    _titleSec = Color.fromARGB(255, 158, 200, 185);
    _bgColor = Color.fromARGB(255, 27, 66, 66);
    _bgColorDark = Color.fromARGB(255, 9, 38, 53);
    _redPrimary = Color.fromARGB(255, 209, 250, 234);
  }

  void _setPalette5() {
    _titlePrimary = Color.fromARGB(255, 190, 49, 68);
    _titleSec = Color.fromARGB(255, 240, 89, 65);
    _bgColor = Color.fromARGB(255, 135, 35, 65);
    _bgColorDark = Color.fromARGB(255, 34, 9, 44);
    _redPrimary = Color.fromARGB(255, 250, 197, 250);
  }
}
