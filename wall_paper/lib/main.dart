import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:wall_paper/firebase_options.dart';
import 'package:wall_paper/firebaseservices/auth_service.dart';
import 'package:wall_paper/firebaseservices/notifications_services.dart';
import 'package:wall_paper/view/screens/SplashScreen.dart';
import 'package:wall_paper/view/screens/home.dart';
import 'package:wall_paper/view/screens/loginpage.dart';
import 'package:wall_paper/view/screens/ColorProvider.dart';

Future<void> _firebaseBackgroundMessage(RemoteMessage msg) async {
  if (msg.notification != null) {
    print("Some notification is received");
  }
}

Future<void> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationServices().initNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wall-Paper',
      home: FutureBuilder<User?>(
        future: FirebaseServices().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return SplashScreen();
            } else {
              return LoginPage();
            }
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}

void main() async {
  await initializeFirebase();

  ColorProvider colorProvider = ColorProvider();
  await colorProvider.loadSelectedPaletteFromFirebase();

  MobileAds.instance.initialize();

  runApp(
    ChangeNotifierProvider.value(
      value: colorProvider,
      child: const MyApp(),
    ),
  );
}
