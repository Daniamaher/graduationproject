/*//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Housing/pages/Services/Firestoreservice.dart';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/HouseOwnerRegistrationPage.dart';
import 'package:flutter_application_1/Housing/pages/HousesPage.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/houseownerloginpage.dart';
//import 'package:flutter_application_1/Housing/pages/houseownerloginpage.dart';
import 'package:flutter_application_1/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:provider/provider.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate();

  runApp(
    ChangeNotifierProvider(
      create: (context) => FirestoreService(),
      child: MyApp(),
    ),
  );
}





/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '/houseownerlogin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        'houseownerlogin': (context) => HouseOwnerLoginPage(),
      //  '/houseownerregister': (context) => HouseOwnerRegistrationPage(),
      //  '/addHouse': (context) => AddHousePage(),
      //  '/houses': (context) => HousingPage(),
      },
    );
  }
}
*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
            create: (context) => FirestoreService(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'House Owner Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/houseownerlogin',
        routes: {
          '/houseownerlogin': (context) => HouseOwnerLoginPage(),
          '/houseownerregister': (context) => HouseOwnerRegistrationPage(),
           '/houses': (context) => HousingPage(),
           '/addHouse': (context) => AddHousePage(),
          // Add other routes here if needed
      
        },
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/Services/FirestoreService.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:flutter_application_1/Housing/pages/houseownerloginpage.dart';
import 'package:flutter_application_1/Housing/pages/HouseOwnerRegistrationPage.dart';
import 'package:flutter_application_1/Housing/pages/HousesPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_application_1/Housing/pages/Services/FirestoreService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   /* await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );*/

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'House Owner Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/houseownerlogin',
      routes: {
        '/houseownerlogin': (context) => HouseOwnerLoginPage(),
        '/houseownerregister': (context) => HouseOwnerRegistrationPage(),
        '/houses': (context) => HousingPage(),
        '/addHouse': (context) => AddHousePage(),
        '/HouseDetailsPage': (context) => DisplayHouseDetailPage(houseDetails: HouseDetails.defaultData()),

      },
    );
  }

}
