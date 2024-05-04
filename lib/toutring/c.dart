import 'package:flutter/material.dart';

import 'Teacher.dart';

class FullTeacherContainer extends StatelessWidget {
  final Teacher teacher;

  const FullTeacherContainer({Key? key, required this.teacher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(teacher.profilePic),
                radius: 50.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Name: ${teacher.name}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Major: ${teacher.major}'),
            SizedBox(height: 8.0),
            Text('Subject: ${teacher.subject}'),
          ],
        ),
      ),
    );
  }
}
