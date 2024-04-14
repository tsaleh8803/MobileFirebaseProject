import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase_project/widgets/exercise_widget.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class BackPage extends StatefulWidget {
  const BackPage({super.key});

  @override
  State<BackPage> createState() => _BackPageState();
}

class _BackPageState extends State<BackPage> {
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
        title: Text('Back Exercises'),
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
                  name: "Rows",
                  instructions: "Keep your back straight and pull with your back muscles rather than your arms. Once your elbows reach your body, release.",
                  imagePath: "assets/images/row.webp",
                  user: _user,
                ),
                SizedBox(height: 30),
                ExerciseWidget(
                  name: "Pullup",
                  instructions: "With your hands slightly wider than your shoulders, pull your body upwards until your chin reaches the bar. Make sure to use your back rather than your arms.",
                  imagePath: "assets/images/pullup.jpeg",
                  user: _user,
                ),
                SizedBox(height: 30),
                ExerciseWidget(
                  name: "Lat Pulldowns",
                  instructions: "Sit at a pulldown station and grasp the bar with a wide grip, your hands about shoulder-width apart or slightly wider. Lean back slightly, engaging your core, and pull the bar down towards your chest. Focus on drawing your elbows down and back, using your back muscles rather than your arms to move the weight. Slowly release the bar back to the starting position, allowing your arms to fully extend while maintaining control.",
                  imagePath: "assets/images/lat-pulldown.webp",
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
