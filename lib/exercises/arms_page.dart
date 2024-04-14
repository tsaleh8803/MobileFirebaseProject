import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase_project/widgets/exercise_widget.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class ArmsPage extends StatefulWidget {
  const ArmsPage({super.key});

  @override
  State<ArmsPage> createState() => _ArmsPageState();
}

class _ArmsPageState extends State<ArmsPage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        _user = currentUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Arms Exercises'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExerciseWidget(
                  name: "Tricep Extension",
                  instructions: "Hold a dumbbell over your head and slowly bring it downwards. Make sure you keep your shoulders stable and movements slow. When the dumbbell is behind your head, raise it up slowly again.",
                  imagePath: "assets/images/tricep-extension.jpeg",
                  user: _user,
                ),
                SizedBox(height: 30),
                ExerciseWidget(
                  name: "Bicep Curl",
                  instructions: "Keeping your elbows in line with your body, slowly raise the dumbbells by bending your elbows. Do each arm at a time",
                  imagePath: "assets/images/bicepcurl-image.jpeg",
                  user: _user,
                ),
                SizedBox(height: 30),
                ExerciseWidget(
                  name: "Barbell Curl",
                  instructions: "Start with your arms holding the barbell with your wrists facing upwards. Keeping your elbows in line with your body, slowly raise the barbell by bending your elbows. Once the barbell reaches chest level, slowly bring it down",
                  imagePath: "assets/images/barbell-curl.webp",
                  user: _user,
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false,
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Text(
                        "Sign Out",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
