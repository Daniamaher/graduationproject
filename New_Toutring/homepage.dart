import 'package:flutter/material.dart';
import 'package:gradution_project/menu.dart';

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
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed("Fitring");
          },
          child: Text("Go To Toutring Page"),
        ),
      ),
      drawer: Menu(),
    );
  }
}
