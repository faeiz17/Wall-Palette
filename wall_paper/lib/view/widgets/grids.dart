import 'package:flutter/material.dart';
import 'package:wall_paper/model/photosModel.dart';
import 'package:wall_paper/view/screens/fullscreen.dart';

class grideMaker extends StatelessWidget {
  const grideMaker({
    super.key,
    required this.imageWallpapers,
  });

  final List<ImageModel> imageWallpapers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 13,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                mainAxisExtent: 400),
            itemCount: imageWallpapers.length,
            itemBuilder: ((context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreen(
                          image1: imageWallpapers[index].imgSrc,
                          myColor: Colors.white,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 700,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                          height: 800,
                          width: 50,
                          fit: BoxFit.cover,
                          imageWallpapers[index].imgSrc),
                    ),
                  ),
                ))),
      ),
    );
  }
}
