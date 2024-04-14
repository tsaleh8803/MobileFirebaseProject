import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExerciseWidget extends StatefulWidget {
  final String? name;
  final String? instructions;
  final String? imagePath;
  final User? user;

  const ExerciseWidget({super.key,
    this.name,
    this.instructions,
    this.imagePath,
    this.user,
});

  @override
  _ExerciseWidgetState createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  bool addedToWorkout = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
        color: Colors.lightBlueAccent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  widget.instructions!,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                widget.imagePath!,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: addedToWorkout ?() => _removeFromWorkout(widget.name!): _addToWorkout,
                child: Text(addedToWorkout ? 'Remove from Workout' : 'Add to Workout'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addToWorkout() {
    if (!addedToWorkout) {
      String? docId = widget.user?.displayName;
      String? exercisesString;
      String? currentExercise;

      FirebaseFirestore.instance.collection('workouts').doc(docId).get().then((documentSnapshot) {
        if (documentSnapshot.exists) {
          exercisesString = documentSnapshot['exercise'];
          currentExercise = widget.name;

          if(exercisesString!.contains(currentExercise!)){
            print("Exercise already in workout!");
            setState(() {
              addedToWorkout = true;
            });
          }
          else{
            FirebaseFirestore.instance.collection('workouts').doc(docId).update({
              'exercise': documentSnapshot['exercise']=="" ? "${widget.name}":"${documentSnapshot['exercise']}, ${widget.name}"
            }).then((_) {
              print('Exercise added to workout: ${widget.name}');
              setState(() {
                addedToWorkout = true;
              });
            }).catchError((error) {
              print('Failed to update workout: $error');
            });
          }
        } else {
          print('Document does not exist');
        }
      }).catchError((error) {
        print('Error retrieving document: $error');
      });
    } else {
      print('This workout has already been added');
    }
  }

  void _removeFromWorkout(String exerciseToRemove) {

    if (addedToWorkout) {

      String? docId = widget.user?.displayName;
      String? exercisesString;
      String? currentExercise;

      FirebaseFirestore.instance.collection('workouts').doc(docId).get().then((
          documentSnapshot) {
        if (documentSnapshot.exists) {
          exercisesString = documentSnapshot['exercise'];
          currentExercise = widget.name;

          if(exercisesString!.contains(currentExercise!)){

            List<String>? exercises = exercisesString?.split(', ');
            exercises?.remove(exerciseToRemove);
            String? updatedExercisesString = exercises?.join(', ');

            FirebaseFirestore.instance.collection('workouts').doc(docId).update({
              'exercise': updatedExercisesString,
            }).then((_) {
              print('Exercise removed from workout: ${widget.name}');
              setState(() {
                addedToWorkout = false;
              });
            }).catchError((error) {
              print('Failed to update workout: $error');
            });
          }
          else{
            print("Exercise already removed from workout!");
            setState(() {
              addedToWorkout = false;
            });
          }

        } else {
          print('Document does not exist');
        }
      }).catchError((error) {
        print('Error retrieving document: $error');
      });
    } else {
      print('This workout has already been added');
    }
  }
}
