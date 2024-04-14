import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase_project/widgets/exercise_widget.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class LegsPage extends StatefulWidget {
  const LegsPage({super.key});

  @override
  State<LegsPage> createState() => _LegsPageState();
}

class _LegsPageState extends State<LegsPage> {
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
        title: Text('Legs Exercises'),
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
                  name: "Leg Press",
                  instructions:
                      "Stabilize both feet in the middle of the leg press board. Unlock the machine, and lower the board so that your knees are at a 90 degree angle.",
                  imagePath: "assets/images/leg-press-visual.jpeg",
                  user: _user,
                ),
                SizedBox(height: 30),
                ExerciseWidget(
                  name: "Squat",
                  instructions:
                      "Bend your knees so they are at a 90 degree angle. Do not go too low, and keep your back straight",
                  imagePath: "assets/images/squat-image.jpeg",
                  user: _user,
                ),
                SizedBox(height: 30),
                ExerciseWidget(
                  name: "Leg Extension",
                  instructions:
                      "Start with your legs resting against the cushion. Bring your legs up, pushing the cushion upwards.",
                  imagePath: "assets/images/leg-extension.webp",
                  user: _user,
                ),
                SizedBox(height: 30),
                ExerciseWidget(
                  name: "Calf Raises",
                  instructions: "Stand or sit on a ledge where your heels are floating off the ledge. Raise your heels, keeping your forefoot on the ledge. Once you cannot raise them anymore, lower your heels back to the start position",
                  imagePath: "assets/images/calf-raise.png",
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
