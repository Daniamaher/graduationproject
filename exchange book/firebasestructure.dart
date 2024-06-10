import 'package:cloud_firestore/cloud_firestore.dart';
/*
Future<void> initializeFirestoreStructure() async {
  final firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> colleges = [
    {
      'name': 'Computer Information Technology',
      'departments': [
        {
          'name': 'Computer Science',
          'books': [
            {
              'bookName': 'Algorithm Design',
              'bookPrice': '50',
              'imageUrl': 'https://example.com/algorithms.jpg',
              'email': 'example@example.com',
              'uniNumber': '123451'
            },
            {
              'bookName': 'Python Programming',
              'bookPrice': '40',
              'imageUrl': 'https://example.com/python.jpg',
              'email': 'example@example.com',
              'uniNumber': '123451'
            },
          ],
        },
        {
          'name': 'Software Engineering',
          'books': [
            {
              'bookName': 'Software Design Patterns',
              'bookPrice': '60',
              'imageUrl': 'https://example.com/design_patterns.jpg',
              'email': 'example@example.com',
              'uniNumber': '123451'
            },
          ],
        },
      ],
    },
    {
      'name': 'Electrical Engineering',
      'departments': [
        {
          'name': 'Power Systems',
          'books': [
            {
              'bookName': 'Power System Analysis',
              'bookPrice': '70',
              'imageUrl': 'https://example.com/power_systems.jpg',
              'email': 'example@example.com',
              'uniNumber': '12345'
            },
          ],
        },
      ],
    },
  ];

  for (var college in colleges) {
    final collegeRef = await firestore.collection('Colleges').add({
      'name': college['name'],
    });

    final departments = college['departments'] as List<Map<String, dynamic>>;
    for (var department in departments) {
      final departmentRef = await collegeRef.collection('Departments').add({
        'name': department['name'],
      });

      final books = department['books'] as List<Map<String, dynamic>>;
      for (var book in books) {
        await departmentRef.collection('Books').add(book);
      }
    }
  }
}
*/