



import 'package:firebase_auth/firebase_auth.dart';



class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String name, String email, String password) async {
    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      user?.updateDisplayName(name);
      return user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        print("The email address is already in use.");
      } else {
        print("An error occurred: ${e.code}");
      }
    }
    return null;

  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        print("Invalid email or password");
      } else {
        print("An error occurred: ${e.code}");
      }

    }
    return null;
  }
}