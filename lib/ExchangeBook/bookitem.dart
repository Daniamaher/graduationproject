import 'package:flutter/material.dart';
import 'package:flutter_application_1/ExchangeBook/displaybookpage.dart';
import 'package:flutter_application_1/constant.dart';

import 'package:provider/provider.dart';
/*
class BookItem extends StatelessWidget {
  BookItem({
    super.key,
    this.bookName,
    required this.bookPrice,
    this.imageUrl,
    this.email,
   // this.UniNumber,
  });
  final bookName;
  final String bookPrice;
  final imageUrl;
  final email;
 // final UniNumber;
  @override
  Widget build(BuildContext context) {
    //final currentUser = Provider.of<UserProvider>(context).currentUser;

    return GestureDetector(
      onTap: () {
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayBook(
              title: bookName,
              price: bookPrice,
              email: email,
              imageurl: imageUrl,
              uniNumber: UniNumber,
            ),
          ),
        );*/
      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageUrl != null
                ? Image.network(
                    imageUrl!,
                    height: 110,
                    width: 150,
                    // fit: BoxFit.cover,
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 110,
                    child: Center(
                      child: Text('Image not available'),
                    ),
                  ),
            Text(bookName),
            Center(
                child: Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                '$bookPrice\$',
                style: TextStyle(fontSize: 15, color: Colors.yellowAccent),
              ),
            )),
          ],
        ),
      ),
    );
  }
}*/








/*40px

import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final String? bookName;
  final String bookPrice;
  final List<String>? imageUrls;
  final String? email;

  BookItem({
    Key? key,
    this.bookName,
    required this.bookPrice,
    this.imageUrls,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? imageUrl = imageUrls != null && imageUrls!.isNotEmpty ? imageUrls!.first : null;

    return GestureDetector(
      onTap: () {
        // Implement navigation to DisplayBook page if needed
      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageUrl != null
                ? Image.network(
                    imageUrl,
                    height: 110,
                    width: 150,
                    fit: BoxFit.cover,
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 110,
                    child: Center(
                      child: Text('Image not available'),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                bookName ?? 'No title',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '$bookPrice\$',
                  style: TextStyle(fontSize: 15, color: Colors.yellowAccent),
                ),
              ),
            ),
            if (email != null)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    email!,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
*/














import 'package:flutter/material.dart';
/*
class BookItem extends StatelessWidget {
  final String? bookName;
  final String bookPrice;
  final List<String>? imageUrls;
  final String? email;

  BookItem({
    Key? key,
    this.bookName,
    required this.bookPrice,
    this.imageUrls,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? imageUrl = imageUrls != null && imageUrls!.isNotEmpty ? imageUrls!.first : null;

    return GestureDetector(
      onTap: () {
        // Implement navigation to DisplayBook page if needed
      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageUrl != null
                ? Image.network(
                    imageUrl,
                    height: 150,
                    width: 110,
                    fit: BoxFit.cover,
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 110,
                    child: Center(
                      child: Text('Image not available'),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                bookName ?? 'No title',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '$bookPrice\$',
                  style: TextStyle(fontSize: 15, color: Colors.yellowAccent),
                ),
              ),
            ),
            if (email != null)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    email!,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
*/











import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final String? bookName;
  final String bookPrice;
  final List<String>? imageUrls;
  final String? email;

  BookItem({
    Key? key,
    this.bookName,
    required this.bookPrice,
    this.imageUrls,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? imageUrl = imageUrls != null && imageUrls!.isNotEmpty ? imageUrls!.first : null;

    return GestureDetector(
     onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DisplayBookPage(
        bookName: bookName,
        bookPrice: bookPrice,
        imageUrls: imageUrls,
        email: email,
      ),
    ),
  );
},
      child: Container(
        color: ksecondaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageUrl != null
                ? Image.network(
                    imageUrl,
                    height: 130,
                    width: 130,
                    fit: BoxFit.cover,
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 110,
                    child: Center(
                      child: Text('Image not available'),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                bookName ?? 'No title',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Text(
                  '$bookPrice\$',
                  style: TextStyle(fontSize: 15, color: Colors.yellowAccent),
                ),
              ),
            ),
              
          ],
        ),
      ),
    );
  }
}
