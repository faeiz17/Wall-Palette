import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wall_paper/model/photosModel.dart';

class ApiOperations {
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchWallpapers = [];
  static List<ImageModel> imageWallpapers = [];

  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    try {
      final response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated"),
        headers: {
          "Authorization":
              "o6I0gNV4RX0G4W2HaNKXOmxGnejBKw7ItWpEvda6dXvSguoDAm7edqx2",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List photos = jsonData["photos"];
        trendingWallpapers.clear();
        photos.forEach((element) {
          trendingWallpapers.add(PhotosModel.fromAPI2App(element));
        });
        return trendingWallpapers;
      } else {
        Fluttertoast.showToast(
            msg:
                "Failed to load trending wallpapers. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred: $e");
      return [];
    }
  }

  static Future<List<PhotosModel>> SearchWallpaper(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=300&page=1"),
        headers: {
          "Authorization":
              "o6I0gNV4RX0G4W2HaNKXOmxGnejBKw7ItWpEvda6dXvSguoDAm7edqx2",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List photos = jsonData["photos"];
        searchWallpapers.clear();
        photos.forEach((element) {
          searchWallpapers.add(PhotosModel.fromAPI2App(element));
        });
        return searchWallpapers;
      } else {
        Fluttertoast.showToast(
            msg:
                "Failed to load search wallpapers. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred: $e");
      return [];
    }
  }

  static Future<List<ImageModel>> imageWallpaper(String query) async {
    try {
      final response = await http.get(
        Uri.parse("https://lexica.art/api/v1/search?q=$query"),
      );

      if (response.statusCode == 200) {
        List<dynamic> images = jsonDecode(response.body)['images'];
        imageWallpapers.clear();
        imageWallpapers.addAll(images.map((json) {
          return ImageModel.fromAPI2App(json);
        }));
        return imageWallpapers;
      } else {
        Fluttertoast.showToast(
            msg:
                "Failed to load image wallpapers. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred: $e");
      return [];
    }
  }
}
