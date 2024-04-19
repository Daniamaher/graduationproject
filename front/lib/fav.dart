import 'package:flutter/material.dart';
import 'package:front/components/Teacher.dart';
import 'package:front/tout.dart';

class BookmarkedTeachersPage extends StatelessWidget {
  final List<Teacher> bookmarkedTeachers;

  const BookmarkedTeachersPage({Key? key, required this.bookmarkedTeachers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bookmarked Teachers'),
        ),
        body: ListView.builder(
          itemCount: bookmarkedTeachers.length,
          itemBuilder: (context, index) {
            final teacher = bookmarkedTeachers[index];
            return ListTile(
              title: Text(teacher.name),
              subtitle:
                  Text('Major: ${teacher.major} - Subject: ${teacher.subject}'),
            );
          },
        ),
        drawer: Menu());
  }
}
