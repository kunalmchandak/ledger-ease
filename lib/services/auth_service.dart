import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/screens/dashboard.dart';
import 'package:finance_management/services/db.dart';
// import 'package:finance_management/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  var db = Db();

  Future<bool> doesEmailExist(String email) async {
    // Query your database to check if the email already exists
    // You can implement this based on your database structure
    // For example, if you're using Firebase Firestore:
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return querySnapshot.docs.isNotEmpty;
    // return false;
  }

  createUser(data, context) async {
    try {
      // Check if email already exists
      bool emailExists = await doesEmailExist(data['email']);

      if (emailExists) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Sign Up Failed"),
              content: const Text("Email already exists. Please use a different email."),
            );
          },
        );
        return; // Exit method if email exists
      }

      // Proceed with user creation if email doesn't exist
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      await db.addUser(data, context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Sign Up Failed"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  login(data, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Login Failed"),
              content: Text(e.toString()),
            );
          });
    }
  }
}
