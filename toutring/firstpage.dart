import 'package:flutter/material.dart';

import 'DropdownButton.dart';
import 'textformfield.dart';


class FormPage1 extends StatefulWidget {
  const FormPage1({Key? key}) : super(key: key);

  @override
  State<FormPage1> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage1> {
  TextEditingController name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController phone = TextEditingController();
  String? _selectedGender;
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE6F3F3),
        body: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: ListView(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 50),
                  Text(
                      "Mind sharing a few tidbits with us? We'll need some info!",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111236))),
                  const SizedBox(height: 20),
                  const Text(
                    "Full Name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF111236)),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(hinttext: "ُYour Name ", mycontroller: name),
                  const SizedBox(height: 10),
                  const Text(
                    "Email",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF111236)),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(hinttext: "ُYour Email ", mycontroller: Email),
                  const SizedBox(height: 10),
                  const Text(
                    "Phone ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF111236)),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(hinttext: "ُphone ", mycontroller: phone),
                  const SizedBox(height: 10),
                  const Text(
                    "Gender",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF111236)),
                  ),
                  const SizedBox(height: 10),
                  GenderDropdownButton(
                    items: ['Male', 'Female'],
                    selectedValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    hint: 'Select Your gender',
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        child: Text(
                          'Next  ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFFE6F3F3)),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF111236),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('FormPage2');
                        },
                      ),
                    ],
                  ),
                ])
              ])),
        ));
  }
}
