import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Housing/pages/widgets/customTextField.dart';


class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({Key? key}) : super(key: key);

  @override
  State<StudentLoginPage> createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorMessage;
  bool firstLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 150),
              Center(
                child: Image.asset(
                  'images/imageicon.png',
                  width: 220,
                  height: 220,
                ),
              ),
              SizedBox(height: 20),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              CustomTextField(
                hint: 'Email',
                controller: emailController,
              ),
              SizedBox(height: 20),
              CustomTextField(
                hint: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: 170,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () async {
                      try {
                        // Fetch the 'users' collection from Firestore
                        var querySnapshot = await FirebaseFirestore.instance
                            .collection('users')
                            .get();

                        // Iterate over each document in the collection
                        for (var doc in querySnapshot.docs) {
                          // Get the data for each document
                          var data = doc.data() as Map<String, dynamic>;

                          // Compare the inputted email and password with Firestore data
                          if (data['id'] == emailController.text &&
                              data['pass'] == passwordController.text) {
                            bool FirstLogin = data['FirstLogin'] ??
                                true; // Use the current value of firstLogin from Firestore, defaulting to true if not set

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FirstLogin
                                    ? TeachOrNotScreen(
                                        userId: emailController.text,
                                      )
                                    : ProfileScreen(
                                        userId: emailController.text,
                                      ), // Use HomeScreen for non-first login
                              ),
                            ).then((_) {
                              // Update the 'firstlogon' field in Firestore only if firstLogin is true
                              if (FirstLogin) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(emailController.text)
                                    .update({'FirstLogin': false}).then((_) {
                                  print(
                                      'firstlogon status updated in Firestore');
                                }).catchError((error) {
                                  print(
                                      'Failed to update firstlogon status: $error');
                                });
                              }
                            });
                            return;
                          }
                        }

                        setState(() {
                          errorMessage = 'Invalid ID or password';
                        });
                      } catch (e) {
                        print('Error: $e');
                        setState(() {
                          errorMessage =
                              'An error occurred. Please try again later.';
                        });
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
