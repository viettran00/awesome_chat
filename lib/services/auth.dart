import 'package:awesome_chat/screens/home_screen.dart';
import 'package:awesome_chat/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  AuthMethods();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushReplacementNamed(HomeScreen.id);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email or password incorrect😂")));
    }
  }

  Future<void> createUserInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Notice"),
        content: Text("Sign up successfully!!!"),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(SignInScreen.id, (route) => false);
            },
          ),
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Sign up fail: The email address is already in use by another account")));
    }
  }

  Future<void> resetPasswordWithEmail(String email, BuildContext context) async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Notice"),
        content: Text("password reset link has been sent to your email!!!"),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                      (Route<dynamic> route) => false);
            },
          ),
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User does not exist!!!")));
    }
  }

}
