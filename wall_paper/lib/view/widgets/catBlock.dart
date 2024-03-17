import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall_paper/view/screens/search.dart';
import 'package:wall_paper/view/screens/selected_category.dart';

class CategoryBlock extends StatelessWidget {
  final String category;
  String imageUrls;

  CategoryBlock({required this.category, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Selected_Category_Screen(
                      query: category,
                      imageUrls: imageUrls,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrls,
                fit: BoxFit.cover,
                height: 100,
                width: 150,
                // // Replace the image URL with the appropriate one for each category
                // // For simplicity, I'm using the same image for all categories
              ),
            ),
            Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.white),
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(12)),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: 0,
              child: FractionallySizedBox(
                heightFactor: 0.2,
                widthFactor: 0.8,
                child: Text(category.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
