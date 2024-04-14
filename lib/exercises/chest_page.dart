import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase_project/widgets/exercise_widget.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class ChestPage extends StatefulWidget {
  const ChestPage({super.key});

  @override
  State<ChestPage> createState() => _ChestPageState();
}

class _ChestPageState extends State<ChestPage> {
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
        title: Text('Chest Exercises'),
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
                  name: "Bench Press",
                  instructions: "Hold the bar with your hands at shoulder length away from each other. Drop the bar slowly towards your chest then raise it up again, making sure to use your chest rather than your shoulders.",
                  imagePath: "assets/images/bench-press.jpeg",
                  user: _user,
                ),
                SizedBox(height: 30),
                ExerciseWidget(
                  name: "Cable Fly",
                  instructions: "Using both cables on the machine, lean forward and push the cables in front of you. Activate your chest and move slowly.",
                  imagePath: "assets/images/cable-fly.png",
                  user: _user,
                ),
                SizedBox(height: 30),
                ExerciseWidget(
                  name: "Incline Bench Press",
                  instructions: "Set an incline bench to 30-45 degrees. Lie back and grip the barbell slightly wider than shoulder width. Plant your feet, maintain a back arch, and retract your shoulder blades. Lift the bar, lower it slowly to your upper chest, then press it back up, extending your arms fully.",
                  imagePath: "assets/images/incline-bench.jpeg",
                  user: _user,
                ),
                SizedBox(height: 30),
                ExerciseWidget(
                  name: "Pushups",
                  instructions: "Start in a plank position with hands just outside shoulder width. Bend your elbows to lower your body to the floor, keeping your body straight and core engaged, then push back up to the start position.",
                  imagePath: "assets/images/pushup.png",
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
