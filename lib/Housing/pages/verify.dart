/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Housing/pages/HousesPage.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  late FirebaseAuth auth;
  late User? user;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    user = auth.currentUser;
    user!.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      checkEmailVerified();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HousingPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'An email has been sent to:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                '${user!.email}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Please verify your email ',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/













import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Housing/pages/HousesPage.dart';

class VerifyScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String nationalNumber;
  final String phoneNumber;
  final String email;
  final String password;

  const VerifyScreen({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.nationalNumber,
    required this.phoneNumber,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  late FirebaseAuth auth;
  late User? user;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    user = auth.currentUser;
    user!.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      checkEmailVerified();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }




Future<void> checkEmailVerified() async {
  user = auth.currentUser;
  await user!.reload();
  if (user!.emailVerified) {
    timer.cancel();
    await addUserToDatabase(); // Add user to database
    try {
      // Create user credential after email verification
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: widget.email,
            password: widget.password,
          );

      print('User created: ${userCredential.user!.uid}');
    } catch (e) {
      print('Error creating user: $e');
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HousingPage()),
    );
  }
}



  Future<void> addUserToDatabase() async {
    try {
      String userId = user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'firstName': widget.firstName,
        'lastName': widget.lastName,
        'nationalNumber': widget.nationalNumber,
        'phoneNumber': widget.phoneNumber,
        'email': widget.email,
        'password': widget.password,
      });
    } catch (e) {
      print('Error adding user to database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'An email has been sent to:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                '${user!.email}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Please verify your email ',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









