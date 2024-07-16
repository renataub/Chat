import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;// אימות משתמש

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;// מסד נתונים(צאט)

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      _firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set(
        {
        'uid': userCredential.user!.uid,
        email: email,
        },
        SetOptions(merge: true),
      );

      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  Future <UserCredential> signUpWithEmailPassword(String email, String password) async {
    try {

      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        }
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  String getErrorMessage(String errorcode){
    switch (errorcode){
      case 'Exception: wrong-password':
        return 'wrong password, try again';
      case 'Exception: user-not-found':
        return 'user not found with this email, please sign up';
      case 'Exception: invalid-email':
        return 'email does not exist';
      default:
        return 'an error accurred';
    }
  }

}