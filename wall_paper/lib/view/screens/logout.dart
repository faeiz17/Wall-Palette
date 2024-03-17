import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wall_paper/view/screens/ColorProvider.dart';
import 'package:wall_paper/view/screens/loginpage.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      setState(() {
        _user = currentUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    return Scaffold(
      backgroundColor: colorProvider.bgColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        //title: Text('User Info'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: _user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Email: ${_user!.email}',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.065,
                        color: colorProvider.titleSec),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          colorProvider.titlePrimary),
                    ),
                    onPressed: () {
                      // You can implement a sign out functionality here
                      _signOut();
                    },
                    child: Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
    Fluttertoast.showToast(msg: "User logged out");
  }
}

void main() {
  runApp(MaterialApp(
    home: UserInfoScreen(),
  ));
}
