

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ExchangeBook/addbookpage.dart';
import 'package:flutter_application_1/ExchangeBook/collegelistpage.dart';
import 'package:flutter_application_1/ExchangeBook/departmentlistpage.dart';
import 'package:flutter_application_1/ExchangeBook/displaybookpage.dart';
import 'package:flutter_application_1/ExchangeBook/firebasestructure.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:flutter_application_1/Housing/pages/houseownerloginpage.dart';
import 'package:flutter_application_1/Housing/pages/HouseOwnerRegistrationPage.dart';
import 'package:flutter_application_1/Housing/pages/HousesPage.dart';
import 'package:flutter_application_1/toutring/Setting.dart';
import 'package:flutter_application_1/toutring/TechingOrNot.dart';
import 'package:flutter_application_1/toutring/WanttoTech.dart';
import 'package:flutter_application_1/toutring/filtering.dart';
import 'package:flutter_application_1/toutring/homepage.dart';
import 'package:flutter_application_1/toutring/menu.dart';
import 'package:flutter_application_1/toutring/profile.dart';
import 'package:flutter_application_1/toutring/studentLoginPage.dart';
import 'package:flutter_application_1/toutring/studentRegistrationPage.dart';
import 'package:flutter_application_1/toutring/verifystudent.dart';

import 'package:provider/provider.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'exchangebook/exchangebookpage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


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
      initialRoute: '/StudentLoginPage',
      routes: {
          'houseownerloginpage': (context) => HouseOwnerLoginPage(),

        'houseownerregister': (context) => HouseOwnerRegistrationPage (),
        'houses': (context) => HousingPage(),
        'addHouse': (context) => AddHousePage(),

        'HouseDetailsPage': (context) => DisplayHouseDetailPage(houseDetails: HouseDetails.defaultData()),

         '/StudentLoginPage': (context) => StudentLoginPage(),
        '/ StudentrRegistrationPage': (context) => StudentRegistrationPage(),

        '/Home': (context) => Home(),
        'ProfileScreen': (context) => ProfileScreen(),
        'SettingForStudents': (context) => SettingsPage(),
        'StudentsWhoWantToTeachScreen': (context) =>
            StudentsWhoWantToTeachScreen(),
        "Menu": (context) => Menu(),
        "Fitring": (context) => Fitring(),
        'VerifyStudentScreen' :(context) => VerifyStudentScreen(),
        'TeachOrNotScreen' :(context) => TeachOrNotScreen(),
        
                      ' AddBookPage' :(context) =>  AddBookPage(),
                      'DepartmentListPage' :(context) =>  DepartmentListPage(),

              'CollegeListPage' :(context) => CollegeListPage(),
                            'ExchangeBookPage' :(context) => ExchangeBookPage(),
          'DisplayBookPage' :(context) => DisplayBookPage()



          
             



      },
    );
  }


}


