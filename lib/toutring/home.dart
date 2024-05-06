import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F3F3),
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50),
            children: [
              SizedBox(height: 100),
              buildButton(context, 'images/t4.jpg', 'Toutring',
                  'MultiChoiceFilterPage'),
              SizedBox(height: 30),
              buildButton(context, 'images/g2.jpg', 'Housing',
                  'HouseOwnerLoginPage'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(
      BuildContext context, String imagePath, String text, String name) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(name);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Ink(
        color: Color(0xFFE6F3F3),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 250,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(fontSize: 20.0, color: Color(0xFF111236)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
