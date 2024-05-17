import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/Housing/pages/HouseOwnerRegistrationPage.dart';
import 'package:flutter_application_1/Housing/pages/HousesPage.dart';
import 'package:flutter_application_1/Housing/pages/houseownerloginpage.dart';
import 'StudentLoginPage.dart';
import 'fav.dart';
import 'firebase_options.dart';
import 'firstpage.dart';
import 'home.dart';
import 'profile.dart';
import 's.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: FormPage1(),
      initialRoute: '/HouseOwnerLoginPage',

      routes: {
        'FormPage1': (context) => FormPage1(),
        //'FormPage2': (context) => FormPage2(),
        'ProfileScreen': (context) => ProfileScreen(
              userId: '',
            ),
        'BookmarkedTeachersPage': (context) => BookmarkedTeachersPage(
              bookmarkedTeachers: [],
            ),
        'MultiChoiceFilterPage': (context) => MultiChoiceFilterPage(),
        "Home": (context) => Home(),
        "StudentLoginPage": (context) => const StudentLoginPage(),
        //"HousingPage": (context) => HousingPage()
        //"HouseOwnerLoginPage": (context) => const HouseOwnerLoginPage(),
          //      '/houses': (context) => HousingPage(),
           
      },
    );
  }
}