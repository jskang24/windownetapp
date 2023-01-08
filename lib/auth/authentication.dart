import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../pages/loginPage/loginPage.dart';
import '../pages/dashboard/dashboard.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String email, String password) async {
    await userCollection.doc(uid).set({
      'userName': name,
      'uid': uid,
    });
    await userCollection
        .doc(uid)
        .collection('rooms')
        .doc('dummy')
        .set({'roomName': 'Dummy'});
  }
}

class AuthService {
  //Determine if the user is authenticated
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (FirebaseAuth.instance.currentUser != null) {
            return Dashboard();
          } else {
            return LoginPage();
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Sign in
  signIn(String email, String password, context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((val) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
      print('signed in');
    }).catchError((e) {});
  }

  //Sign up
  signUp(String name, String email, String password, context) async {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;
    await DatabaseService(uid: user!.uid).updateUserData(name, email, password);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
    return result;
  }

  //Sign up
  // signUp(String email, String password) {
  //   return FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(email: email, password: password);
  // }

  //Reset password
  resetPass(String email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
