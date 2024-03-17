import 'package:care_rental/colors.dart';
import 'package:flutter/material.dart';

class Porsche {
  String name;
  String modelYear;
  List<Color> colors;
  String color;
  double price;
  String imageUrl;
  bool isfavourite;

  Porsche({
    required this.name,
    required this.modelYear,
    required this.colors,
    required this.price,
    required this.imageUrl,
    required this.color,
    this.isfavourite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'modelYear': modelYear,
      'color': colors,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory Porsche.fromJson(Map<String, dynamic> json) {
    return Porsche(
      name: json['name'],
      modelYear: json['modelYear'],
      colors: json['colors'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      color: json["color"],
    );
  }
}

class Porsche911Variant extends Porsche {
  Porsche911Variant({
    required String name,
    required String modelYear,
    required List<Color> colors,
    required double price,
    required String imageUrl,
    required String color,
  }) : super(
          name: name,
          modelYear: modelYear,
          colors: colors,
          price: price,
          imageUrl: imageUrl,
          color: color,
        );
}

List<Porsche911Variant> porsche911Variants = [
  Porsche911Variant(
    name: 'Porsche 911 Carrera',
    modelYear: '2022',
    colors: [bluePrimary, blueSec],
    price: 120.0,
    color: "Midnight Blue",
    imageUrl: 'assets/p_911.png', // Local image
  ),
  Porsche911Variant(
    name: 'Porsche 911 Turbo',
    modelYear: '2022',
    colors: [yelowprimary, yellowSec],
    price: 180.0,
    color: "Chronic Gold",
    imageUrl: 'assets/porsche_turbo_image.png', // Local image
  ),
  Porsche911Variant(
    name: 'Porsche 911 GT3',
    modelYear: '2022',
    colors: [greenprimary, greenSec],
    price: 160.0,
    color: "Grean Tea",
    imageUrl: 'assets/porsche_gt3_image.png', // Internet image
  ),
];

// class PorschePanameraVariant extends Porsche {
//   PorschePanameraVariant({
//     required String name,
//     required String modelYear,
//     required String color,
//     required double price,
//     required String imageUrl,
//   }) : super(
//           name: name,
//           modelYear: modelYear,
//           color: color,
//           price: price,
//           imageUrl: imageUrl,
//         );
// }

// // Add more Porsche variant classes as needed
