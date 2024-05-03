import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectInfo {
  String name;
  double price;
  bool preferOnline;

  SubjectInfo(
      {required this.name, required this.price, required this.preferOnline});
}

class TeachOrNotScreen extends StatefulWidget {
  final String userId;

  TeachOrNotScreen({required this.userId});

  @override
  _TeachOrNotScreenState createState() => _TeachOrNotScreenState();
}

class _TeachOrNotScreenState extends State<TeachOrNotScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _wantsToTeach = false;
  Map<String, SubjectInfo> _subjectsToTeach = {};
  List<String> _allSubjects = [
    'Math',
    'Science',
    'History',
    'English',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic> subjectsData = {};
      _subjectsToTeach.forEach((key, value) {
        subjectsData[key] = {
          'price': value.price,
          'preferOnline': value.preferOnline,
        };
      });

      FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
        'wantsToTeach': _wantsToTeach,
        'subjectsToTeach': _wantsToTeach ? subjectsData : FieldValue.delete(),
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User information updated successfully'),
        ));
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update user information: $error'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teach or Not Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  CheckboxListTile(
                    title: Text('I want to teach'),
                    value: _wantsToTeach,
                    onChanged: (value) {
                      setState(() {
                        _wantsToTeach = value!;
                      });
                    },
                  ),
                  if (_wantsToTeach)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subjects I want to teach:'),
                        Wrap(
                          children: _allSubjects
                              .map(
                                (subject) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CheckboxListTile(
                                      title: Text(subject),
                                      value:
                                          _subjectsToTeach.containsKey(subject),
                                      onChanged: (value) {
                                        setState(() {
                                          if (value!) {
                                            _subjectsToTeach[subject] =
                                                SubjectInfo(
                                              name: subject,
                                              price: 0.0,
                                              preferOnline: false,
                                            );
                                          } else {
                                            _subjectsToTeach.remove(subject);
                                          }
                                        });
                                      },
                                    ),
                                    if (_subjectsToTeach.containsKey(subject))
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            decoration: InputDecoration(
                                                labelText: 'Price per hour'),
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                            validator: (value) {
                                              if (value == null ||
                                                  double.tryParse(value) ==
                                                      null) {
                                                return 'Please enter a valid price';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _subjectsToTeach[subject]!.price =
                                                  double.parse(value!);
                                            },
                                          ),
                                          CheckboxListTile(
                                            title:
                                                Text('Prefer Online Teaching'),
                                            value: _subjectsToTeach[subject]!
                                                .preferOnline,
                                            onChanged: (value) {
                                              setState(() {
                                                _subjectsToTeach[subject]!
                                                    .preferOnline = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
