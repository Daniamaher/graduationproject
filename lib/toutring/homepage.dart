import 'package:flutter/material.dart';
import 'package:flutter_application_1/ExchangeBook/collegelistpage.dart';
import 'package:flutter_application_1/ExchangeBook/exchangebookpage.dart';
import 'package:flutter_application_1/toutring/menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("Fitring");
              },
              child: Text("Go To Toutring Page"),

            ),
            SizedBox(height:30),
             TextButton(
              onPressed: () {
               



               Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                  
                    return CollegeListPage();
                  },
                ),
              );


              },
              child: Text("Exchange Book Page"),
            ),
          ],
        ),
      ),
      drawer: Menu(),
    );
  }
}