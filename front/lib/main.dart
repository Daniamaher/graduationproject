import 'package:flutter/material.dart';
import 'package:front/collectinfo/firstpage.dart';
import 'package:front/collectinfo/secpage.dart';
import 'package:front/components/DependentDropdownPage.dart';
import 'package:front/components/nav.dart';
import 'package:front/fav.dart';
import 'package:front/home.dart';
import 'package:front/profile.dart';
import 'package:front/s.dart';
import 'package:front/tout.dart';

void main() {
  runApp(const MyApp());
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
      home: FormPage1(),
      routes: {
        'FormPage1': (context) => FormPage1(),
        'FormPage2': (context) => FormPage2(),
        'ProfileScreen': (context) => ProfileScreen(),
        'BookmarkedTeachersPage': (context) => BookmarkedTeachersPage(
              bookmarkedTeachers: [],
            ),
        'MultiChoiceFilterPage': (context) => MultiChoiceFilterPage(),
        "Home": (context) => Home()
      },
    );
  }
}
