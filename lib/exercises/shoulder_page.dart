import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase_project/widgets/exercise_widget.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class ShoulderPage extends StatefulWidget {
  const ShoulderPage({super.key});

  @override
  State<ShoulderPage> createState() => _ShoulderPageState();
}

class _ShoulderPageState extends State<ShoulderPage> {
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
        title: Text('Shoulder Exercises'),
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
                  name: "Shoulder Press",
                  instructions: "Holding a dumbbell in each hand, Start at the position where your elbows are in line with your shoulders. Raise them up vertically so that your arms are straightened out upwards.",
                  imagePath: "assets/images/shoulder-press.jpeg",
                  user: _user,
                ),
                SizedBox(height: 30),
                ExerciseWidget(
                  name: "Lateral Raises",
                  instructions: "Start with the dumbbells by your waist. Raise them up horizontally, making sure that your arms are not bent.",
                  imagePath: "assets/images/lateral-raise.webp",
                  user: _user,
                ),
                SizedBox(height: 30),
                ExerciseWidget(
                  name: "Rear Delt Fly",
                  instructions: "Sit on the bench facing the seat, and set up the handles accordingly (furthest position backwards). Adjust the seat so that your arms are parallel to the ground, and then start pulling the handles outwards. Your right hand will be moving clockwise, while your left anti-clockwise. When your arms are in line with your shoulders, release.",
                  imagePath: "assets/images/rear-delt-fly.webp",
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
