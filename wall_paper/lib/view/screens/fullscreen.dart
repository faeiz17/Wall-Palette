import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:wall_paper/view/screens/ColorProvider.dart';
import 'package:wall_paper/view/screens/ads.dart';
import 'package:wall_paper/view/screens/fullerscreen.dart';
import 'package:wall_paper/view/screens/wave.dart';
import 'package:wall_paper/view/widgets/CustomAppBar.dart';

class FullScreen extends StatefulWidget {
  final String image1;
  final Color myColor;
  FullScreen({super.key, required this.image1, required this.myColor});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ...

  Future<void> addDataToFirestore(String data) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get a reference to the Firestore collection for the user
        CollectionReference userCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('data');

        // Check if the data already exists
        QuerySnapshot querySnapshot =
            await userCollection.where('data', isEqualTo: data).get();

        if (querySnapshot.docs.isEmpty) {
          // Add a new document with the given data
          await userCollection.add({'data': data});
          Fluttertoast.showToast(msg: "wallpaper has been added to favorites");
        } else {
          Fluttertoast.showToast(msg: "wallpaper is already in favorites");
        }
      } else {
        print('User not logged in.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "some error ${e}");
    }
  }

  void downloadingimage() async {
    try {
      await GallerySaver.saveImage(widget.image1, toDcim: true);
      //Fluttertoast.showToast(msg: "walls are broken successfully");

      // The image is saved successfully
    } catch (e) {
      // Handle the error
      print('Error saving image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.myColor,
      appBar: AppBar(
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: widget.myColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BannerAdWidget(),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullerScreen(
                          image1: widget.image1,
                          //builder: (context) => AdScreen() // ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    //height: MediaQuery.of(context).size.height,
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.image1))),
                  ),
                ),
              ),
              Positioned(
                left: 50,
                bottom: 20,
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullerScreen(
                          image1: widget.image1,
                          //builder: (context) => AdScreen() // ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Tap to view in full screen",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.065),
                  ),
                ),
              )
            ],
          ),
          Stack(
            children: [
              Positioned(left: 0, bottom: 0, right: 0, child: WaveBackground()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      downloadingimage();
                      Fluttertoast.showToast(msg: "Downloading has finished");
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text("Download",
                            style: TextStyle(
                                color: colorProvider.titleSec,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          addDataToFirestore(widget.image1);
                        },
                        child: Text(
                          "Add to fav",
                          style: TextStyle(
                              color: colorProvider.titleSec,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
