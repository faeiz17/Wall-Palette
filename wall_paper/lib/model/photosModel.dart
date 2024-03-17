// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PhotosModel {
  String imgSrc;
  String PhotoName;

  Color myColor;

  PhotosModel(
      {required this.imgSrc,
      required this.PhotoName,
      //required this.hexColor,
      required this.myColor});

  factory PhotosModel.fromAPI2App(Map<String, dynamic> photoMap) {
    String hexColor = photoMap["avg_color"];
    Color color =
        Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
    return PhotosModel(
      imgSrc: (photoMap["src"])["portrait"],
      PhotoName: photoMap["photographer"],
      myColor: color,
    );
  }
}

class ImageModel {
  String imgSrc;
  ImageModel({
    required this.imgSrc,
  });
  static fromAPI2App(Map<String, dynamic> imageMap) {
    return ImageModel(
      imgSrc: imageMap["src"],
    );
  }
}
