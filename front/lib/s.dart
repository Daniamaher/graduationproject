import 'package:flutter/material.dart';
import 'package:front/c.dart';
import 'package:front/components/Teacher.dart';
import 'package:front/tout.dart';
import 'fav.dart';

class MultiChoiceFilterPage extends StatefulWidget {
  @override
  _MultiChoiceFilterPageState createState() => _MultiChoiceFilterPageState();
}

class _MultiChoiceFilterPageState extends State<MultiChoiceFilterPage> {
  List<Teacher> _teachers = [
    Teacher(
      name: 'John Doe',
      major: 'Mathematics',
      subject: 'Algebra',
      profilePic: 'images/4.jpg',
    ),
    Teacher(
      name: 'Jane Smith',
      major: 'English',
      subject: 'Literature',
      profilePic: 'images/4.jpg',
    ),
    Teacher(
      name: 'John Doe',
      major: 'Mathematics',
      subject: 'Algebra',
      profilePic: 'images/4.jpg',
    ),
    Teacher(
      name: 'Jane Smith',
      major: 'English',
      subject: 'Literature',
      profilePic: 'images/4.jpg',
    ),
    Teacher(
      name: 'John Doe',
      major: 'Mathematics',
      subject: 'Algebra',
      profilePic: 'images/4.jpg',
    ),
    Teacher(
      name: 'Jane Smith',
      major: 'English',
      subject: 'Literature',
      profilePic: 'images/4.jpg',
    ),
    Teacher(
      name: 'John Doe',
      major: 'Mathematics',
      subject: 'Algebra',
      profilePic: 'images/4.jpg',
    ),
    Teacher(
      name: 'Jane Smith',
      major: 'English',
      subject: 'Literature',
      profilePic: 'images/4.jpg',
    ),
    // Add more teachers here...
  ];

  List<Teacher> _filteredTeachers = [];
  List<Teacher> _bookmarkedTeachers = [];

  @override
  void initState() {
    super.initState();
    _filteredTeachers.addAll(_teachers);
  }

  void _filterTeachers(String query) {
    setState(() {
      _filteredTeachers = _teachers
          .where((teacher) =>
              teacher.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleBookmark(Teacher teacher) {
    setState(() {
      if (_bookmarkedTeachers.contains(teacher)) {
        _bookmarkedTeachers.remove(teacher);
      } else {
        _bookmarkedTeachers.add(teacher);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE6F3F3),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: _filterTeachers,
                  decoration: InputDecoration(
                    labelText: 'Filter Teachers',
                    suffixIcon: Icon(Icons.search),
                    // border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredTeachers.length,
                    itemBuilder: (context, index) {
                      final teacher = _filteredTeachers[index];
                      return TeacherItemWidget(
                        teacher: teacher,
                        isBookmarked: _bookmarkedTeachers.contains(teacher),
                        onBookmarkToggle: () => _toggleBookmark(teacher),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookmarkedTeachersPage(
                    bookmarkedTeachers: _bookmarkedTeachers),
              ),
            );
          },
          child: Icon(Icons.bookmark),
        ),
        drawer: Menu());
  }
}

class TeacherItemWidget extends StatelessWidget {
  final Teacher teacher;
  final bool isBookmarked;
  final VoidCallback onBookmarkToggle;

  const TeacherItemWidget(
      {Key? key,
      required this.teacher,
      required this.isBookmarked,
      required this.onBookmarkToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullTeacherContainer(teacher: teacher),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  /* image: DecorationImage(
            image: AssetImage(widget.teacher.profilePic),
            fit: BoxFit.cover,
        ),*/
                  color: Colors.amber)),
          title: Text(teacher.name),
          subtitle:
              Text('Major: ${teacher.major} - Subject: ${teacher.subject}'),
          trailing: IconButton(
            icon: isBookmarked
                ? Icon(Icons.bookmark)
                : Icon(Icons.bookmark_border),
            onPressed: onBookmarkToggle,
          ),
        ),
      ),
    );
  }
}
