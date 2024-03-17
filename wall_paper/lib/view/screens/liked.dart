import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wall_paper/view/screens/ColorProvider.dart';
import 'package:wall_paper/view/screens/fullscreen.dart';
import 'package:wall_paper/view/widgets/CustomAppBar.dart';

class LikedImagesScreen extends StatefulWidget {
  LikedImagesScreen({Key? key}) : super(key: key);

  @override
  _LikedImagesScreenState createState() => _LikedImagesScreenState();
}

class _LikedImagesScreenState extends State<LikedImagesScreen> {
  late Future<List<String>> fetchDataFuture;
  List<String> selectedImages = [];

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchDataForCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      backgroundColor: colorProvider.bgColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: CustomAppBar(),
        actions: [
          if (selectedImages.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                // Handle the deletion of selected images
                deleteSelectedImages();
              },
            ),
        ],
      ),
      body: FutureBuilder(
        future: fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<String> fetchedData = snapshot.data as List<String>;

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
                    mainAxisExtent: 400,
                  ),
                  itemCount: fetchedData.length,
                  itemBuilder: (context, index) {
                    String imageUrl = fetchedData[index];

                    return GestureDetector(
                      onLongPress: () {
                        // Toggle the selection on long-press
                        setState(() {
                          if (selectedImages.contains(imageUrl)) {
                            selectedImages.remove(imageUrl);
                          } else {
                            selectedImages.add(imageUrl);
                          }
                        });
                      },
                      onTap: () {
                        // Navigate to full-screen on tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreen(
                              image1: imageUrl,
                              myColor: colorProvider.bgColorDark,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 800,
                            width: 800,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imageUrl,
                                height: 800,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Selection overlay
                          if (selectedImages.contains(imageUrl))
                            Positioned.fill(
                              child: Container(
                                color: Colors.blue.withOpacity(0.3),
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // Function to handle the deletion of selected images
  void deleteSelectedImages() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        CollectionReference userCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('data');

        // Delete selected images
        for (String imageUrl in selectedImages) {
          QuerySnapshot querySnapshot =
              await userCollection.where('data', isEqualTo: imageUrl).get();
          querySnapshot.docs.forEach((DocumentSnapshot document) {
            document.reference.delete();
            Fluttertoast.showToast(msg: "walls are broken successfully");
          });
        }

        // Clear the selection
        setState(() {
          selectedImages.clear();
        });

        print('Selected images deleted successfully!');
        Navigator.pop(
            context, MaterialPageRoute(builder: (_) => LikedImagesScreen()));
      }
    } catch (e) {
      print('Error deleting selected images: $e');
    }
  }
}

Future<List<String>> fetchDataForCurrentUser() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference userCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('data');

      QuerySnapshot querySnapshot = await userCollection.get();

      List<String> dataList = [];
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        String data = document['data'] ?? '';
        dataList.add(data);
      });

      print('Data fetched from Firestore successfully!');
      return dataList;
    } else {
      print('No user is currently signed in.');
      return [];
    }
  } catch (e) {
    print('Error fetching data from Firestore: $e');
    return [];
  }
}
