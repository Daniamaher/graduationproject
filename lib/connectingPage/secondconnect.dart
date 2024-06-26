
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cstum/menu.dart';
import 'package:flutter_application_1/Cstum/widgitforconnect.dart';
import 'package:flutter_application_1/constant.dart';
class Secondconnect extends StatelessWidget {
  const Secondconnect({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F3F3),
      appBar: AppBar(
          title: Text(
            "Let's Study",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white)),
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50),
            children: [
              SizedBox(height: 100),
              buildButton(context, 'images/t4 (1).jpg', 'Tutoring', "Fitring"),
              buildButton(
                  context, 'images/g2 (1).jpg', 'Study With Me','VotedList'),
            ],
          ),
        ),
      ),
      drawer: Menu(),
    );
  }
}