/*import 'package:flutter/material.dart';
import 'package:front/components/DependentDropdownPage.dart';

class FormPage2 extends StatefulWidget {
  @override
  _FormPage2State createState() => _FormPage2State();
}

class _FormPage2State extends State<FormPage2> {
  String? selectedCategory;
  String? selectedSubcategory;

  Map<String, List<String>> categoryMap = {
    'Computer and Information Technology': [
      'Artificial Intelligence',
      'Computer Engineering',
      'Computer Science',
      'Cybersecurity',
      'Data Science',
      'Information Systems',
      'Information Technology',
      'Network Engineering',
      'Software Engineering'
    ],
    'Engineering': [
      'Agricultural Engineering',
      'Aerospace Engineering',
      'Biomedical Engineering',
      'Chemical Engineering',
      'Civil Engineering',
      'Electrical Engineering',
      'Industrial Engineering',
      'Mechanical Engineering',
      'Nuclear Engineering'
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F3F3),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 50),
              DependentDropdownPage(
                categoryMap: categoryMap,
                selectedCategory: selectedCategory,
                selectedSubcategory: selectedSubcategory,
                onCategoryChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue;
                    selectedSubcategory = null; // Reset subcategory
                  });
                },
                onSubcategoryChanged: (newValue) {
                  setState(() {
                    selectedSubcategory = newValue;
                  });
                },
                hint1: 'your department is ',
                hint2: 'your major is ',
                firstbox: 'Select your department',
                Secbox: 'Select your major',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Text(
                      'Finsh  ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFFE6F3F3)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF111236),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('ProfileScreen');
                    },
                  ),
                ],
              ),
            ])
          ])),
    );
  }
}*/

import 'package:flutter/material.dart';

class FormPage2 extends StatefulWidget {
  @override
  _FormPage2State createState() => _FormPage2State();
}

class _FormPage2State extends State<FormPage2> {
  String? selectedCategory;
  String? selectedSubcategory;
  List<String> subjectsToTeach = [];
  bool wantsToTeach = false;

  Map<String, Map<String, List<String>>> categoryMap = {
    'Computer and Information Technology': {
      'Computer Science': [
        'Algorithms and Data Structures',
        'Computer Architecture',
        'Operating Systems',
        'Database Systems',
        'C++'
      ],
      'Information Technology': [
        'Subject 4',
        'Subject 5',
        'Subject 6',
      ],
    },
    'Engineering': {
      'Mechanical Engineering': [
        'Subject A',
        'Subject B',
        'Subject C',
      ],
      'Electrical Engineering': [
        'Subject X',
        'Subject Y',
        'Subject Z',
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F3F3),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategory = newValue;
                      selectedSubcategory = null; // Reset subcategory
                      subjectsToTeach.clear(); // Clear selected subjects
                    });
                  },
                  items: categoryMap.keys.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text('Your department is '),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedSubcategory,
                  onChanged: (newValue) {
                    setState(() {
                      selectedSubcategory = newValue;
                      subjectsToTeach.clear(); // Clear selected subjects
                    });
                  },
                  items: getSubcategories().map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text('Your major is '),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: wantsToTeach,
                      onChanged: (value) {
                        setState(() {
                          wantsToTeach = value!;
                        });
                      },
                    ),
                    Text('I want to teach'),
                  ],
                ),
                if (wantsToTeach &&
                    selectedCategory != null &&
                    selectedSubcategory != null)
                  Column(
                    children: [
                      Text('Subjects in ${selectedSubcategory!}:'),
                      SizedBox(height: 10),
                      Wrap(
                        children: getSubjects().map((subject) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FilterChip(
                              label: Text(subject),
                              selected: subjectsToTeach.contains(subject),
                              onSelected: (isSelected) {
                                setState(() {
                                  if (isSelected) {
                                    subjectsToTeach.add(subject);
                                  } else {
                                    subjectsToTeach.remove(subject);
                                  }
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: Text(
                    'Finish',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFFE6F3F3),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF111236),
                  ),
                  onPressed: () {
                    // Handle finish button press
                    Navigator.of(context).pushNamed('ProfileScreen');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<String> getSubcategories() {
    if (selectedCategory != null) {
      return categoryMap[selectedCategory!]!.keys.toList();
    }
    return [];
  }

  List<String> getSubjects() {
    if (selectedCategory != null && selectedSubcategory != null) {
      return categoryMap[selectedCategory!]![selectedSubcategory!]!;
    }
    return [];
  }
}
