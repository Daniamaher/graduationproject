import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gradution_project/Setting.dart';
import 'package:gradution_project/WanttoTech.dart';
import 'package:gradution_project/fltring.dart';
import 'package:gradution_project/homepage.dart';
import 'package:gradution_project/menu.dart';
import 'package:gradution_project/profile.dart';
import 'package:gradution_project/studentLoginPag.dart';
import 'package:gradution_project/studentRegistrationPage.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  BindingBase.debugZoneErrorsAreFatal = true;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student LoginPage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/StudentLoginPage',
      routes: {
        '/StudentLoginPage': (context) => StudentLoginPage(),
        '/ StudentrRegistrationPage': (context) => StudentRegistrationPage(),
        '/Home': (context) => Home(),
        'ProfileScreen': (context) => ProfileScreen(),
        'SettingForStudents': (context) => SettingsPage(),
        'StudentsWhoWantToTeachScreen': (context) =>
            StudentsWhoWantToTeachScreen(),
        "Menu": (context) => Menu(),
        "Fitring": (context) => Fitring(),
      },
    );
  }
}
