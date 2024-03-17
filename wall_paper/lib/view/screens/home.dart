import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wall_paper/controller/apiOper.dart';
import 'package:wall_paper/model/photosModel.dart';
import 'package:wall_paper/view/screens/colorselectionscreen.dart';
import 'package:wall_paper/view/screens/fullscreen.dart';
import 'package:wall_paper/view/screens/imageAi.dart';
import 'package:wall_paper/view/screens/liked.dart';
import 'package:wall_paper/view/screens/loginpage.dart';
import 'package:wall_paper/view/screens/logout.dart';

import 'package:wall_paper/view/widgets/CustomAppBar.dart';
import 'package:wall_paper/view/widgets/SearchBar.dart';
import 'package:wall_paper/view/widgets/catBlock.dart';
import 'package:wall_paper/view/screens/ColorProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final advancedDrawerController = AdvancedDrawerController();

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    'Abstract',
    'Nature',
    '4K',
    'Art',
    'Black',
    'Minimal',
    'Love',
    'Neon',
    'Space',
  ];
  List<String> imageUrls = [
    'https://images.pexels.com/photos/2832382/pexels-photo-2832382.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    "https://images.pexels.com/photos/3571551/pexels-photo-3571551.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1585325/pexels-photo-1585325.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/2923591/pexels-photo-2923591.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/3028961/pexels-photo-3028961.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1378723/pexels-photo-1378723.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/2215609/pexels-photo-2215609.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/816608/pexels-photo-816608.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  ];
  List<PhotosModel> trendingWallList = [];
  List<PhotosModel> likedWallList = [];
  getTrendingWallpapers() async {
    trendingWallList = await ApiOperations.getTrendingWallpapers();
    setState(() {});
  }

  @override
  void dispose() {
    trendingWallList.clear();
    super.dispose();
  }

  @override
  void initState() {
    trendingWallList.clear();
    super.initState();
    getTrendingWallpapers();
  }

  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [colorProvider.bgColorDark, colorProvider.titlePrimary])),
      child: AdvancedDrawer(
        rtlOpening: false,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        openScale: 0.8,
        openRatio: 0.6,
        backdropColor: Colors.transparent,
        controller: advancedDrawerController,
        drawer: const Draw(),
        child: Scaffold(
          backgroundColor: colorProvider.bgColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                drawerController();
              },
              icon: const Icon(FontAwesomeIcons.alignJustify),
            ),
            actionsIconTheme: IconThemeData(color: colorProvider.titleSec),
            iconTheme: IconThemeData(color: colorProvider.titleSec),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: const CustomAppBar(),
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: Searchbar(),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                  height: 100,
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) => CategoryBlock(
                      category: categories[index],
                      imageUrls: imageUrls[index],
                    ),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Trending Wallpapers",
                        style: TextStyle(
                            color: colorProvider.titleSec,
                            fontSize: MediaQuery.of(context).size.width * 0.065,
                            fontStyle: FontStyle.italic),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 400,
                ),
                delegate: trendingWallList.isEmpty
                    ? SliverChildListDelegate([
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ])
                    : SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Transform(
                              transform: Matrix4.skewY(
                                  0.2), // Adjust the skew factor as needed

                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FullScreen(
                                            image1:
                                                trendingWallList[index].imgSrc,
                                            myColor:
                                                trendingWallList[index].myColor,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 1300,
                                      width: 800,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          trendingWallList[index].imgSrc,
                                          height: 1200,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        ),
                                        color: trendingWallList[index].myColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            trendingWallList[index].PhotoName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: trendingWallList.length,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void drawerController() {
    advancedDrawerController.showDrawer();
  }
}

class Draw extends StatelessWidget {
  const Draw({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    return SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: colorProvider.titleSec,
          iconColor: colorProvider.bgColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: colorProvider.bgColorDark,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 8.0, top: 30),
                  child: RichText(
                      text: TextSpan(
                          text: "W",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: colorProvider.titlePrimary,
                              fontSize: 60,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: "P",
                            style: TextStyle(
                                color: colorProvider.titleSec,
                                fontSize: 60,
                                fontWeight: FontWeight.bold))
                      ])),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ColorSelectionScreen(),
                    ),
                  );
                },
                leading: const Icon(FontAwesomeIcons.paintRoller),
                title: const Text('Color Palette'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                leading: const Icon(Icons.home),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => aiimage()),
                  );
                },
                leading: const Icon(FontAwesomeIcons.robot),
                title: const Text('AI Generated-Beta Version'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LikedImagesScreen(),
                    ),
                  );
                },
                leading: const Icon(Icons.favorite),
                title: const Text('Favourites'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserInfoScreen(),
                    ),
                  );
                  //FirebaseAuth.instance.signOut();

                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => LoginPage()));
                  //Fluttertoast.showToast(msg: "User logged out");
                },
                leading: const Icon(Icons.logout),
                title: const Text('logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
