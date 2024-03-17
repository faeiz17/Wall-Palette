import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wall_paper/firebaseservices/auth_service.dart';
import 'package:wall_paper/view/screens/home.dart';
import 'package:wall_paper/view/screens/loginpage.dart';

//import 'package:wall_paper/view/screens/wave.dart';
import 'package:wall_paper/view/screens/ColorProvider.dart';
import 'package:wall_paper/view/screens/wave.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});
  //TextEditingController _email = TextEditingController();

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseServices _auth = FirebaseServices();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                  height: 70,
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
                            controller: _usernameController,
                            cursorColor: colorProvider.titleSec,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Username",
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
                            controller: _emailController,
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
                            controller: _passwordController,
                            cursorColor: colorProvider.titleSec,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Password",
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
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                        child: GestureDetector(
                          onTap: () async {
                            String username = _usernameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            User? user =
                                await _auth.signUpMethod(email, password);

                            if (user != null) {
                              Fluttertoast.showToast(
                                  msg: "Account is successfully created");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomeScreen()));
                            }
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginPage()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: colorProvider.titlePrimary, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          WaveBackground(),
        ],
      ),
    );
  }
}
