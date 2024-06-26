
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cstum/menu.dart';
import 'package:flutter_application_1/Cstum/widgitforconnect.dart';
import 'package:flutter_application_1/constant.dart';
class Firstconnet extends StatelessWidget {
  const Firstconnet({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F3F3),
      appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white)),
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50),
            children: [
              buildButton(context, 'images/1.jpg', 'Housing', 'houses'),
              buildButton(
                  context, 'images/e2.jpg', 'Exchange Book', 'CollegeListPage'),
              buildButton(
                  context, 'images/y2.jpg', "Let's Study", 'Secondconnect')
            ],
          ),
        ),
      ),
      drawer: Menu(),
    );
  }
}