



/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ExchangeBook/editbookpage.dart';
import 'package:flutter_application_1/constant.dart';

class DisplayBookPage extends StatelessWidget {
  final String? bookName;
  final String? bookPrice;
  final List<String>? imageUrls;
  final String? email;
  final String? additionalDetails;
  final String? bookStatus;
  final String? bookId;
  final String? collegeId;
  final String? departmentId;
  final String? userId;

  const DisplayBookPage({
    this.bookName,
    this.bookPrice,
    this.imageUrls,
    this.email,
    this.additionalDetails,
    this.bookStatus,
    this.bookId,
    this.collegeId,
    this.departmentId,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print('7:51----------------------gggggggggggggggggggggg');
    print('user id from widget $userId ');
    print('User ID: ${user?.uid}');
    
    print("now at 1:6 i am trying to find the error");
    print('Book Name: $bookName');
    print('Book Price: $bookPrice');
    print('Email: $email');
    print('Additional Details: $additionalDetails');
    print('Book Status: $bookStatus');
    print('College ID: $collegeId');
    print('Department ID: $departmentId');
    print('Book ID: $bookId');

    return Scaffold(
      //backgroundColor: ksecondaryColor,
      appBar: AppBar(backgroundColor: kPrimaryColor,
                        iconTheme: IconThemeData(color: ksecondaryColor),

        title: Text('Book Details',style: TextStyle(color: ksecondaryColor),),
        actions: [
          if (user != null && userId == user.uid)
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditBookPage(bookData: {
                      'bookName': bookName,
                      'bookPrice': bookPrice,
                      'imageUrls': imageUrls,
                      'additionalDetails': additionalDetails,
                      'bookStatus': bookStatus,
                      'bookId': bookId,
                      'collegeId': collegeId,
                      'departmentId': departmentId,
                    }),
                  ),
                );
              },
            ),
          if (user != null && userId == user.uid)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text('Are you sure you want to delete this book?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {

          CollectionReference bookCollection = FirebaseFirestore.instance
        .collection('Colleges')
        .doc(collegeId)
        .collection('Departments')
        .doc(departmentId)
        .collection('Books');


                               
          

                              QuerySnapshot querySnapshot = await bookCollection
                                  .where('bookName', isEqualTo: bookName)
                                  .where('bookPrice', isEqualTo: bookPrice)
                                  .where('email', isEqualTo: email)
                                  .get();

                              if (querySnapshot.docs.isNotEmpty) {
                                await bookCollection.doc(querySnapshot.docs.first.id).delete();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Book deleted successfully'),
                                  ),
                                );

                                Navigator.pop(context); // Close the dialog
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('No matching book found'),
                                  ),
                                );
                              }
                            } catch (e) {
                              print('Error deleting book: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to delete book. Please try again later.'),
                                ),
                              );
                            }
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Container(
                height: 300,
                width: double.infinity,
                child: imageUrls != null && imageUrls!.isNotEmpty
                    ? Image.network(
                        imageUrls![0],
                        fit: BoxFit.cover,
                      
                      )
                    : Center(
                        child: Text('Image not available'),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Book Name: ${bookName ?? 'Not available'}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Price: ${bookPrice ?? 'Not available'}\$',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${email ?? 'Not available'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Additional Details: ${additionalDetails ?? 'Not available'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Book Status: ${bookStatus ?? 'Not available'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Images:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageUrls != null ? imageUrls!.length : 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            imageUrls![index],
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/








/*wor



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ExchangeBook/editbookpage.dart';
import 'package:flutter_application_1/constant.dart';

class DisplayBookPage extends StatefulWidget {
  final String? bookName;
  final String? bookPrice;
  final List<String>? imageUrls;
  final String? email;
  final String? additionalDetails;
  final String? bookStatus;
  final String? bookId;
  final String? collegeId;
  final String? departmentId;
  final String? userId;

  const DisplayBookPage({
    this.bookName,
    this.bookPrice,
    this.imageUrls,
    this.email,
    this.additionalDetails,
    this.bookStatus,
    this.bookId,
    this.collegeId,
    this.departmentId,
    this.userId,
  });

  @override
  _DisplayBookPageState createState() => _DisplayBookPageState();
}

class _DisplayBookPageState extends State<DisplayBookPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: ksecondaryColor),
        title: Text(
          'Book Details',
          style: TextStyle(color: ksecondaryColor),
        ),
        actions: [
          if (user != null && widget.userId == user?.uid)
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditBookPage(
                      bookData: {
                        'bookName': widget.bookName,
                        'bookPrice': widget.bookPrice,
                        'imageUrls': widget.imageUrls,
                        'additionalDetails': widget.additionalDetails,
                        'bookStatus': widget.bookStatus,
                        'bookId': widget.bookId,
                        'collegeId': widget.collegeId,
                        'departmentId': widget.departmentId,
                      },
                    ),
                  ),
                );
              },
            ),
          if (user != null && widget.userId == user?.uid)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content:
                          Text('Are you sure you want to delete this book?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              CollectionReference bookCollection =
                                  FirebaseFirestore.instance
                                      .collection('Colleges')
                                      .doc(widget.collegeId)
                                      .collection('Departments')
                                      .doc(widget.departmentId)
                                      .collection('Books');

                              QuerySnapshot querySnapshot = await bookCollection
                                  .where('bookName',
                                      isEqualTo: widget.bookName)
                                  .where('bookPrice',
                                      isEqualTo: widget.bookPrice)
                                  .where('email', isEqualTo: widget.email)
                                  .get();

                              if (querySnapshot.docs.isNotEmpty) {
                                await bookCollection
                                    .doc(querySnapshot.docs.first.id)
                                    .delete();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Book deleted successfully'),
                                  ),
                                );

                                Navigator.pop(context); // Close the dialog
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('No matching book found'),
                                  ),
                                );
                              }
                            } catch (e) {
                              print('Error deleting book: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Failed to delete book. Please try again later.'),
                                ),
                              );
                            }
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Container(
                height: 300,
                width: double.infinity,
                child: widget.imageUrls != null && widget.imageUrls!.isNotEmpty
                    ? Image.network(
                        widget.imageUrls![0],
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Text('Image not available'),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Book Name: ${widget.bookName ?? 'Not available'}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Price: ${widget.bookPrice ?? 'Not available'}\$',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${widget.email ?? 'Not available'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Additional Details: ${widget.additionalDetails ?? 'Not available'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Book Status: ${widget.bookStatus ?? 'Not available'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Images:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.imageUrls != null
                          ? widget.imageUrls!.length
                          : 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            widget.imageUrls![index],
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
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
*/



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ExchangeBook/editbookpage.dart';
import 'package:flutter_application_1/constant.dart';

class DisplayBookPage extends StatelessWidget {
 

  final String? bookName;
  final String? bookPrice;
  final List<String>? imageUrls;
  final String? email;
  final String? additionalDetails;
  final String? bookStatus;
  final String? bookId;
  final String? collegeId;
  final String? departmentId;
  final String? userId;

  const DisplayBookPage({
     this.bookName,
    this.bookPrice,
    this.imageUrls,
    this.email,
    this.additionalDetails,
    this.bookStatus,
    this.bookId,
    this.collegeId,
    this.departmentId,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: ksecondaryColor),
        title: Text('Book Details', style: TextStyle(color: ksecondaryColor)),
        actions: [
          if (user != null && userId == user.uid)
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {

                        Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditBookPage(bookData: {
                      'bookName': bookName,
                      'bookPrice': bookPrice,
                      'imageUrls': imageUrls,
                      'additionalDetails': additionalDetails,
                      'bookStatus': bookStatus,
                      'bookId': bookId,
                      'collegeId': collegeId,
                      'departmentId': departmentId,
                    }),
                  ),
                );
              },



            ),
          if (user != null && userId == user.uid)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text('Are you sure you want to delete this book?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              CollectionReference bookCollection = FirebaseFirestore.instance
                                  .collection('Colleges')
                                  .doc(collegeId)
                                  .collection('Departments')
                                  .doc(departmentId)
                                  .collection('Books');

                              await bookCollection.doc(bookId).delete();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Book deleted successfully'),
                                ),
                              );

                              Navigator.pop(context); // Close the dialog
                            } catch (e) {
                              print('Error deleting book: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to delete book. Please try again later.'),
                                ),
                              );
                            }
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Colleges')
            .doc(collegeId)
            .collection('Departments')
            .doc(departmentId)
            .collection('Books')
            .doc(bookId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Book not found'));
          }

          var bookData = snapshot.data!.data() as Map<String, dynamic>;
          String? bookName = bookData['bookName'];
          String? bookPrice = bookData['bookPrice'];
          List<String>? imageUrls = List<String>.from(bookData['imageUrls'] ?? []);
          String? email = bookData['email'];
          String? additionalDetails = bookData['additionalDetails'];
          String? bookStatus = bookData['bookStatus'];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    child: imageUrls.isNotEmpty
                        ? Image.network(
                            imageUrls[0],
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text('Image not available'),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Book Name: ${bookName ?? 'Not available'}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Price: ${bookPrice ?? 'Not available'}\$',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Email: ${email ?? 'Not available'}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Additional Details: ${additionalDetails ?? 'Not available'}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Book Status: ${bookStatus ?? 'Not available'}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Images:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Image.network(
                                imageUrls[index],
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
