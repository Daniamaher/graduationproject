import 'package:flutter/material.dart';
import 'package:front/collectinfo/firstpage.dart';
import 'package:front/collectinfo/secpage.dart';
import 'package:front/components/DependentDropdownPage.dart';
import 'package:front/components/nav.dart';
import 'package:front/fav.dart';
import 'package:front/firebase_options.dart';
import 'package:front/home.dart';
import 'package:front/StudentLoginPage.dart';
import 'package:front/profile.dart';
import 'package:front/s.dart';
import 'package:front/thechornotScreen.dart';
import 'package:front/tout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
      initialRoute: "StudentLoginPage",

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
      },
    );
  }
}
