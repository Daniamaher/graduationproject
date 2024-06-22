
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cstum/menu.dart';
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
import 'package:flutter_application_1/authForStudent/ResetPasswordPage.dart';
import 'package:flutter_application_1/authForStudent/Verify.dart';
import 'package:flutter_application_1/authForStudent/studentLoginPag.dart';
import 'package:flutter_application_1/authForStudent/studentRegistrationPage.dart';
import 'package:flutter_application_1/connectingPage/Welcomepage.dart';
import 'package:flutter_application_1/connectingPage/firstconnetc.dart';
import 'package:flutter_application_1/connectingPage/secondconnect.dart';
import 'package:flutter_application_1/poll/CreateVoteForm.dart';
import 'package:flutter_application_1/poll/list.dart';
import 'package:flutter_application_1/poll/votelist.dart';
import 'package:flutter_application_1/poll/voting.dart';
import 'package:flutter_application_1/toutring/Setting.dart';
import 'package:flutter_application_1/toutring/TechingOrNot.dart';
import 'package:flutter_application_1/toutring/WanttoTech.dart';
import 'package:flutter_application_1/toutring/filtering.dart';
import 'package:flutter_application_1/toutring/homepage.dart';
import 'package:flutter_application_1/toutring/profile.dart';


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
      title: 'ease your uni life',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'Welcomepage',
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
        'VerifyStudentScreen' :(context) => VerifyStusentScreen (),
        'TeachOrNotScreen' :(context) => TeachOrNotScreen(),

                      ' AddBookPage' :(context) =>  AddBookPage(),
                      ' DepartmentListPage' :(context) =>  DepartmentListPage(),
              'CollegeListPage' :(context) => CollegeListPage(),
                            'ExchangeBookPage' :(context) => ExchangeBookPage(),
          'DisplayBookPage' :(context) => DisplayBookPage(),
             '/ LoginStateless': (context) => StudentLoginPage(),
        '/ StudentrRegistrationPage': (context) => StudentRegistrationPage(),
        '/Home': (context) => Home(),
        'ProfileScreen': (context) => ProfileScreen(),
        'SettingForStudents': (context) => SettingsPage(),
        'StudentsWhoWantToTeachScreen': (context) =>
            StudentsWhoWantToTeachScreen(),
        "Menu": (context) => Menu(),
        "Fitring": (context) => Fitring(),
        'Dashboured': (context) => Dashboured(),
        'VotingScreen': (context) => VotingScreen(),
        //'CreateVoteForm': (context) => CreateVoteForm(),
        "VoteList": (context) => VoteList(),
       // 'VotedList': (context) => VotedList(),
        'TeachOrNotScreen': (context) => TeachOrNotScreen(),
        'Secondconnect': (context) => Secondconnect(),
        'Firstconnet': (context) => Firstconnet(),
                'ResetPasswordPage': (context) => ResetPasswordPage(),
                        'VotingScreen': (context) => VotingScreen(),
        'CreateVoteForm': (context) => CreateVoteForm(),
        'VotedList': (context) => VotedList(),
                    'exchange': (context) => ExchangeBookPage(),
                             "Welcomepage": (context) => Welcomepage()


      },

    );
  }
}


