import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/ExchangeBook/addbookpage.dart';
import 'package:flutter_application_1/ExchangeBook/displaybookpage.dart';
import 'package:flutter_application_1/Housing/myhouse.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/exchangebook/bookitem.dart';






import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
/*correct
class ExchangeBookPage extends StatelessWidget {
  final String? collegeId;
  final String? departmentId;

  const ExchangeBookPage({Key? key, this.collegeId, this.departmentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text('Books in Department'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Book',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return AddBookPage(collegeId: collegeId, departmentId: departmentId);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Colleges')
              .doc(collegeId)
              .collection('Departments')
              .doc(departmentId)
              .collection('Books')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final books = snapshot.data!.docs;
            return Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  List<dynamic> imageUrlsDynamic = book['imageUrls'] ?? [];
                  List<String> imageUrls = imageUrlsDynamic.map((url) => url.toString()).toList();
                  return BookItem(
                    bookName: book['bookName'],
                    bookPrice: book['bookPrice'],
                    imageUrls: imageUrls,
                    email: book['email'],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}


*/













import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExchangeBookPage extends StatelessWidget {
  final String? collegeId;
  final String? departmentId;

  const ExchangeBookPage({Key? key, this.collegeId, this.departmentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text('Books in Department'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Book',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return AddBookPage(collegeId: collegeId, departmentId: departmentId);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Colleges')
              .doc(collegeId)
              .collection('Departments')
              .doc(departmentId)
              .collection('Books')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final books = snapshot.data!.docs;
            return Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  List<dynamic> imageUrlsDynamic = book['imageUrls'] ?? [];
                  List<String> imageUrls = imageUrlsDynamic.map((url) => url.toString()).toList();
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayBookPage (
                            bookName: book['bookName'],
                            bookPrice: book['bookPrice'],
                            imageUrls: imageUrls,
                            email: book['email'],
                            category: book['category'], // Assuming 'category' is a field in your book document
                            // Add other book information as needed
                          ),
                        ),
                      );
                    },
                    child: BookItem(
                      bookName: book['bookName'],
                      bookPrice: book['bookPrice'],
                      imageUrls: imageUrls,
                      email: book['email'],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
