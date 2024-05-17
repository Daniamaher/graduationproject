import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';

class MyHousingPage extends StatelessWidget {
  const MyHousingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
     final   FirebaseAuth auth=FirebaseAuth.instance;
     final  User? user =auth.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Houses'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add House',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return AddHousePage();
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
          stream: firestore.collection('users')
              .doc(user?.uid)
              .collection('houses')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final List<DocumentSnapshot> houseDocs = snapshot.data!.docs;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              itemCount: houseDocs.length,
              itemBuilder: (context, index) {
                final houseData =
                    houseDocs[index].data() as Map<String, dynamic>;
                final List<String> imageUrls =
                    List<String>.from(houseData['imageUrls'] ?? []);
                return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: houseData['price'] ?? '',
                  occupants:
                      int.tryParse(houseData['numOccupants'].toString()) ?? 0,
                  rooms: int.tryParse(houseData['numRooms'].toString()) ?? 0,
                  imageUrls: imageUrls,
                  userId: houseData['userId'],
                  gender: houseData['gender'],
                  email: houseData['email'],
                  bathrooms: houseData['numBathrooms'],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class HouseItem extends StatelessWidget {
  final String houseName;
  final double housePrice;
  final int occupants;
  final int rooms;
  final List<String> imageUrls;
  final String gender;
  final String email;
  final String userId;
  final int bathrooms;

  const HouseItem({
    required this.houseName,
    required this.housePrice,
    required this.occupants,
    required this.rooms,
    required this.imageUrls,
    required this.gender,
    required this.email,
    //required this.phone,
    required this.userId,
    required this.bathrooms,
  });

  @override
  Widget build(BuildContext context) {
    String? firstImageUrl = imageUrls.isNotEmpty ? imageUrls.first : null;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayHouseDetailPage(
              houseDetails: HouseDetails(
                houseName: houseName,
                housePrice: housePrice,
                occupants: occupants,
                rooms: rooms,
                imageUrls: imageUrls,
                gender: gender,
                email: email,
                userId: userId,
                bathrooms: bathrooms,
              ),
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            firstImageUrl != null
                ? Image.network(
                    firstImageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    houseName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Price: $housePrice',
                    style: TextStyle(color: Colors.yellow),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.people),
                      SizedBox(width: 4),
                      Text('Occupants: $occupants'),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.home),
                      SizedBox(width: 4),
                      Text('Rooms: $rooms'),
                      SizedBox(width: 8),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.toilet,
                          color: Colors.black,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(width: 4),
                      Text('bathroom $rooms'),
                    ],
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














/*1/2





import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Housing/myhouse.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({Key? key}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _housesStream;

  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _housesStream = FirebaseFirestore.instance.collectionGroup('houses').snapshots();
  }

  void _toggleSort() {
    setState(() {
      _sortAscending = !_sortAscending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Houses'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add House',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return AddHousePage();
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'My House',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return MyHousingPage();
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            tooltip: 'Sort',
            onPressed: _toggleSort,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _housesStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            List<QueryDocumentSnapshot<Map<String, dynamic>>> houseDocs = snapshot.data!.docs;

            // Filter and sort the houses based on sorting order
            houseDocs.sort((a, b) {
              double priceA = (a['price'] ?? 0) as double; // Convert to double
              double priceB = (b['price'] ?? 0) as double; // Convert to double
              return _sortAscending ? priceA.compareTo(priceB) : priceB.compareTo(priceA);
            });

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: houseDocs.length,
              itemBuilder: (context, index) {
                final houseData = houseDocs[index].data();
                final List<String> imageUrls = List<String>.from(houseData['imageUrls'] ?? []);
                return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: (houseData['price'] ?? 0) as double, // Convert to double
                  occupants: (houseData['numOccupants'] ?? 0) as int,
                  rooms: (houseData['numRooms'] ?? 0) as int,
                  imageUrls: imageUrls,
                  userId: houseData['userId'] ?? '',
                  gender: houseData['gender'] ?? '',
                  email: houseData['email'] ?? '',
                  bathrooms: houseData['numBathrooms'] ?? '', // Leave as String
                );
              },
            );
          },
        ),
      ),
    );
  }
}


class HouseItem extends StatelessWidget {
  final String houseName;
  final double housePrice;
  final int occupants;
  final int rooms;
  final List<String> imageUrls;
  final String gender;
  final String email;
  final String userId;
  final String bathrooms;

  const HouseItem({
    required this.houseName,
    required this.housePrice,
    required this.occupants,
    required this.rooms,
    required this.imageUrls,
    required this.gender,
    required this.email,
    required this.userId,
    required this.bathrooms,
  });

  @override
  Widget build(BuildContext context) {
    String? firstImageUrl = imageUrls.isNotEmpty ? imageUrls.first : null;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayHouseDetailPage(
              houseDetails: HouseDetails(
                houseName: houseName,
                housePrice: housePrice,
                occupants: occupants,
                rooms: rooms,
                imageUrls: imageUrls,
                gender: gender,
                email: email,
                userId: userId,
                bathrooms: bathrooms,
              ),
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (firstImageUrl != null)
              Image.network(
                firstImageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    houseName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Price: \$${housePrice.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.yellow),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.people),
                      SizedBox(width: 4),
                      Text('Occupants: $occupants'),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.home),
                      SizedBox(width: 4),
                      Text('Rooms: $rooms'),
                      SizedBox(width: 8),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.toilet,
                            color: Colors.black, size: 20),
                        onPressed: () {},
                      ),
                      SizedBox(width: 4),
                      Text('Bathrooms: $bathrooms'),
                    ],
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


















/*


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Housing/myhouse.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({Key? key}) : super(key: key);

  @override
  HousingPageState createState() => HousingPageState();
}

class HousingPageState extends State<HousingPage> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> housesStream;

  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    housesStream = FirebaseFirestore.instance.collectionGroup('houses').snapshots();
  }

  void _toggleSort() {
    setState(() {
      _sortAscending = !_sortAscending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Houses'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add House',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return AddHousePage();
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'My House',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return MyHousingPage();
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            tooltip: 'Sort',
            onPressed: _toggleSort,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: housesStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            List<QueryDocumentSnapshot<Map<String, dynamic>>> houseDocs = snapshot.data!.docs;

            // Filter and sort the houses based on sorting order
            houseDocs.sort((a, b) {
              double priceA = (a['price'] ?? 0) as double; // Convert to double
              double priceB = (b['price'] ?? 0) as double; // Convert to double
              return _sortAscending ? priceA.compareTo(priceB) : priceB.compareTo(priceA);
            });

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: houseDocs.length,
              itemBuilder: (context, index) {
                final houseData = houseDocs[index].data();
                final List<String> imageUrls = List<String>.from(houseData['imageUrls'] ?? []);
                return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: (houseData['price'] ?? 0) as double, // Convert to double
                  occupants: (houseData['numOccupants'] ?? 0) as int,
                  rooms: (houseData['numRooms'] ?? 0) as int,
                  imageUrls: imageUrls,
                  userId: houseData['userId'] ?? '',
                  gender: houseData['gender'] ?? '',
                  email: houseData['email'] ?? '',
                  bathrooms: (houseData['numBathrooms'] ?? 0), // Convert to String
                );
              },
            );
          },
        ),
      ),
    );
  }
}


class HouseItem extends StatelessWidget {
  final String houseName;
  final double housePrice;
  final int occupants;
  final int rooms;
  final List<String> imageUrls;
  final String gender;
  final String email;
  final String userId;
  final int bathrooms;

  const HouseItem({
    required this.houseName,
    required this.housePrice,
    required this.occupants,
    required this.rooms,
    required this.imageUrls,
    required this.gender,
    required this.email,
    required this.userId,
    required this.bathrooms,
  });

  @override
  Widget build(BuildContext context) {
    String? firstImageUrl = imageUrls.isNotEmpty ? imageUrls.first : null;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayHouseDetailPage(
              houseDetails: HouseDetails(
                houseName: houseName,
                housePrice: housePrice,
                occupants: occupants,
                rooms: rooms,
                imageUrls: imageUrls,
                gender: gender,
                email: email,
                userId: userId,
                bathrooms: bathrooms,
              ),
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (firstImageUrl != null)
              Image.network(
                firstImageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    houseName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Price: \$${housePrice.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.yellow),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.people),
                      SizedBox(width: 4),
                      Text('Occupants: $occupants'),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.home),
                      SizedBox(width: 4),
                      Text('Rooms: $rooms'),
                      SizedBox(width: 8),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.toilet,
                            color: Colors.black, size: 20),
                        onPressed: () {},
                      ),
                      SizedBox(width: 4),
                      Text('Bathrooms: $bathrooms'),
                    ],
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