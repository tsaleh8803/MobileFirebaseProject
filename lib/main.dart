import 'package:first_firebase_project/exercises/arms_page.dart';
import 'package:first_firebase_project/exercises/back_page.dart';
import 'package:first_firebase_project/exercises/chest_page.dart';
import 'package:first_firebase_project/exercises/legs_page.dart';
import 'package:first_firebase_project/exercises/shoulder_page.dart';
import 'package:first_firebase_project/pages/home_page.dart';
import 'package:first_firebase_project/pages/login_page.dart';
import 'package:first_firebase_project/pages/profile_page.dart';
import 'package:first_firebase_project/pages/signup_page.dart';
import 'package:first_firebase_project/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBt6eqlkBPZvzCCI3xzhvSzFGqKGUeH8kA",
          appId: "1:483317773028:web:5d78757c18f7471418b2f1",
          messagingSenderId: "483317773028",
          projectId: "finalproject-e9a7a"
      ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(
          child: LoginPage(),
        ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/legs': (context) => LegsPage(),
        '/arms': (context) => ArmsPage(),
        '/chest': (context) => ChestPage(),
        '/shoulder': (context) => ShoulderPage(),
        '/back': (context) => BackPage(),
      },
    );
  }
}

