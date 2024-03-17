import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:wall_paper/firebaseservices/auth_service.dart';
import 'package:wall_paper/view/screens/SplashScreen.dart';

import 'package:wall_paper/view/screens/signup.dart';
import 'package:wall_paper/view/screens/wave.dart';
import 'package:wall_paper/view/screens/ColorProvider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn g_signin = GoogleSignIn();
  final FirebaseServices _auth = FirebaseServices();
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _obscureText = true; // Add this line to declare _obscureText

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _email.dispose();
    _password.dispose();
    g_signin.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  colorProvider.bgColorDark,
                  colorProvider.bgColor
                ])),
            child: Column(
              children: [
                SizedBox(
                  height: 110,
                ),
                RichText(
                    text: TextSpan(
                        text: "W",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: colorProvider.titlePrimary,
                            fontSize: 80,
                            fontWeight: FontWeight.bold),
                        children: [
                      TextSpan(
                          text: "P",
                          style: TextStyle(
                              color: colorProvider.titleSec,
                              fontSize: 80,
                              fontWeight: FontWeight.bold))
                    ])),
                Text(
                  "w a l l  p a l e t t e",
                  style: TextStyle(color: colorProvider.titleSec),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: colorProvider.titlePrimary, width: 2),
                      color: Color.fromARGB(10, 139, 139, 139),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _email,
                            cursorColor: colorProvider.titleSec,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle:
                                  TextStyle(color: colorProvider.titlePrimary),
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: colorProvider.titlePrimary, width: 2),
                        color: Color.fromARGB(10, 139, 139, 139),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _password,
                              obscureText: _obscureText,
                              // Controls whether the text is obscured or not
                              cursorColor: colorProvider.titleSec,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: colorProvider.titlePrimary),
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: colorProvider.titleSec,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: GestureDetector(
                    onTap: () async {
                      String email = _email.text;
                      String password = _password.text;
                      User? user = await _auth.signiNMethod(email, password);

                      if (user != null) {
                        Fluttertoast.showToast(msg: "Login successful!");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SplashScreen()));
                      }
                    },
                    child: Container(
                        //width: MediaQuery.of(context).size.width,
                        //padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(left: 10, right: 11),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: colorProvider.titlePrimary, width: 2),
                          color: colorProvider.titlePrimary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6),
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        final GoogleSignInAccount? g_signin_account =
                            await g_signin.signIn();
                        if (g_signin_account != null) {
                          final GoogleSignInAuthentication g_signin_auth =
                              await g_signin_account.authentication;
                          final AuthCredential credential =
                              GoogleAuthProvider.credential(
                            idToken: g_signin_auth.idToken,
                            accessToken: g_signin_auth.accessToken,
                          );
                          await _firebaseauth.signInWithCredential(credential);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SplashScreen()));
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                        //width: MediaQuery.of(context).size.width,
                        //padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(left: 10, right: 11),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: colorProvider.titlePrimary, width: 2),
                          color: colorProvider.titlePrimary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.google,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Google Login",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignUp()));
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: colorProvider.titlePrimary, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    String email = _email.text.trim();

                    try {
                      await _firebaseauth.sendPasswordResetEmail(email: email);

                      Fluttertoast.showToast(
                        msg:
                            "Password reset email sent. Check your email inbox.",
                        toastLength: Toast.LENGTH_LONG,
                      );
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg:
                            "Failed to send password reset email. ${e.toString()}",
                        toastLength: Toast.LENGTH_LONG,
                      );
                    }
                  },
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: colorProvider.titlePrimary,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          WaveBackground(),
        ],
      ),
    );
  }
}
