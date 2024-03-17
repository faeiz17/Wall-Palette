import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:gallery_saver/gallery_saver.dart';
import 'package:wall_paper/controller/apiOper.dart';
import 'package:wall_paper/model/photosModel.dart';
import 'package:wall_paper/view/screens/fullerscreen.dart';
import 'package:wall_paper/view/screens/fullscreen.dart';
import 'package:wall_paper/view/widgets/CustomAppBar.dart';
import 'package:wall_paper/view/screens/ColorProvider.dart';
//import 'package:wall_paper/view/widgets/grids.dart';

class aiimage extends StatefulWidget {
  @override
  _aiimage createState() => _aiimage();
}

class _aiimage extends State<aiimage> {
  TextEditingController _searchController = TextEditingController();
  List<ImageModel> imageWallpapers = [];

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      backgroundColor: colorProvider.bgColor,
      appBar: AppBar(
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(38, 0, 0, 0)),
                  color: Color.fromARGB(10, 139, 139, 139),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: _searchController,
                  cursorColor: colorProvider.titlePrimary,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search your wallpapers here...",
                    hintStyle: TextStyle(color: Colors.white),
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.animation_outlined,
                        color: colorProvider.titlePrimary,
                      ),
                      onPressed: () {
                        _searchImages();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
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
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullerScreen(
                                  image1: imageWallpapers[index].imgSrc,
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
            )
          ],
        ),
      ),
    );
  }

  Future<void> _searchImages() async {
    String query = _searchController.text;
    List<ImageModel> result = await ApiOperations.imageWallpaper(query);

    setState(() {
      imageWallpapers = result;
    });
  }
}
