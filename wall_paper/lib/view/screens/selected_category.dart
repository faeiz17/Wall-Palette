import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wall_paper/controller/apiOper.dart';
import 'package:wall_paper/model/photosModel.dart';
import 'package:wall_paper/view/screens/fullscreen.dart';
import 'package:wall_paper/view/widgets/CustomAppBar.dart';
import 'package:wall_paper/view/screens/ColorProvider.dart';
// import 'package:wall_paper/view/widgets/CustomAppBar.dart';
// import 'package:wall_paper/view/widgets/SearchBar.dart';
// import 'package:wall_paper/view/widgets/catBlock.dart';

class Selected_Category_Screen extends StatefulWidget {
  String query;
  String imageUrls;
  Selected_Category_Screen(
      {super.key, required this.query, required this.imageUrls});

  @override
  State<Selected_Category_Screen> createState() =>
      _Selected_Category_ScreenState();
}

class _Selected_Category_ScreenState extends State<Selected_Category_Screen> {
  List<PhotosModel> categories = [];
  getCategory() async {
    categories = await ApiOperations.SearchWallpaper(widget.query);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategory();
  }

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
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.imageUrls,
                    height: 150,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black54),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 0.9,
                    child: Column(
                      children: [
                        Text(
                          "C A T E G O R Y",
                          style: TextStyle(
                              color: colorProvider.titlePrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.query.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 60),
                        )
                      ],
                    ),
                  ),
                )
              ],
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
                  itemCount: categories.length,
                  itemBuilder: ((context, index) => Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreen(
                                    image1: categories[index].imgSrc,
                                    myColor: categories[index].myColor,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                                height: 800,
                                width: 800,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    height: 800,
                                    width: 300,
                                    fit: BoxFit.cover,
                                    categories[index].imgSrc,
                                  ),
                                )),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                color: categories[index].myColor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                  Text(categories[index].PhotoName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ))
        ]),
      ),
    );
  }
}
