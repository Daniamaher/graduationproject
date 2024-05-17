



















/*










import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';


class HousingPage extends StatelessWidget {
  const HousingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
          stream: firestore.collectionGroup('houses').snapshots(),
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
                final houseData = houseDocs[index].data() as Map<String, dynamic>;
                final List<String> imageUrls = List<String>.from(houseData['imageUrls'] ?? []);
                  return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: houseData['price'] ?? '',
                  occupants: (houseData['numOccupants']) ??0,
                  rooms: (houseData['numRooms']),
                  imageUrls: imageUrls,
                  userId: houseData['userId'],
                  gender: houseData['gender'], // corrected to 'gender'
                  email: houseData['email'],
                  bathrooms: houseData['numBathrooms'], // added bathrooms
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
  final String gender; // corrected to 'gender'
  final String email;
  final String userId;
  final int bathrooms; // added bathrooms

  const HouseItem({
      required this.houseName,
    required this.housePrice,
    required this.occupants,
    required this.rooms,
    required this.imageUrls,
    required this.gender,
    required this.email,
    //required this.phone,
    required this.userId, required this.bathrooms,
  });

  @override
  Widget build(BuildContext context) {
    String? firstImageUrl = imageUrls.isNotEmpty ? imageUrls.first : null;

    return GestureDetector(
      onTap: (){
        
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>DisplayHouseDetailPage(
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
            firstImageUrl != null ? Image.network(
              firstImageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ) : SizedBox.shrink(),
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
                        icon: FaIcon(FontAwesomeIcons.toilet, color: Colors.black, size: 20,), 
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

*/












/*errorindex



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({Key? key}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedSortOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Houses'),
        actions: <Widget>[
          DropdownButton<String>(
            value: selectedSortOrder,
            hint: Text('Sort by Price'),
            items: [
              DropdownMenuItem(value: 'lowToHigh', child: Text('Low to High')),
              DropdownMenuItem(value: 'highToLow', child: Text('High to Low')),
            ],
            onChanged: (value) {
              setState(() {
                selectedSortOrder = value;
              });
            },
          ),
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
          stream: _buildQuery().snapshots(),
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
                final houseData = houseDocs[index].data() as Map<String, dynamic>;
                final List<String> imageUrls = List<String>.from(houseData['imageUrls'] ?? []);
                return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: houseData['price']?.toDouble() ?? 0.0,
                  occupants: houseData['numOccupants'] ?? 0,
                  rooms: houseData['numRooms'] ?? 0,
                  imageUrls: imageUrls,
                  userId: houseData['userId'] ?? '',
                  gender: houseData['gender'] ?? '',
                  email: houseData['email'] ?? '',
                  bathrooms: houseData['numBathrooms'] ?? 0,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Query _buildQuery() {
    Query query = firestore.collectionGroup('houses');
    if (selectedSortOrder == 'lowToHigh') {
      query = query.orderBy('price', descending: false);
    } else if (selectedSortOrder == 'highToLow') {
      query = query.orderBy('price', descending: true);
    }
    return query;
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
                      FaIcon(
                        FontAwesomeIcons.toilet,
                        color: Colors.black,
                        size: 20,
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

class DisplayHouseDetailPage extends StatelessWidget {
  final HouseDetails houseDetails;

  const DisplayHouseDetailPage({required this.houseDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(houseDetails.houseName),
      ),
      body: Center(
        child: Text('Details of ${houseDetails.houseName}'),
      ),
    );
  }
}

class HouseDetails {
  final String houseName;
  final double housePrice;
  final int occupants;
  final int rooms;
  final List<String> imageUrls;
  final String gender;
  final String email;
  final String userId;
  final int bathrooms;

  HouseDetails({
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
}
*/



/*

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({Key? key}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedSortOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Houses'),
        actions: <Widget>[
          DropdownButton<String>(
            value: selectedSortOrder,
            hint: Text('Sort by Price'),
            items: [
              DropdownMenuItem(value: 'lowToHigh', child: Text('Low to High')),
              DropdownMenuItem(value: 'highToLow', child: Text('High to Low')),
            ],
            onChanged: (value) {
              setState(() {
                selectedSortOrder = value;
              });
            },
          ),
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
          stream: _buildQuery().snapshots(),
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
                final houseData = houseDocs[index].data() as Map<String, dynamic>;
                final List<String> imageUrls = List<String>.from(houseData['imageUrls'] ?? []);
                return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: houseData['price']?.toDouble() ?? 0.0,
                  occupants: houseData['numOccupants'] ?? 0,
                  rooms: houseData['numRooms'] ?? 0,
                  imageUrls: imageUrls,
                  userId: houseData['userId'] ?? '',
                  gender: houseData['gender'] ?? '',
                  email: houseData['email'] ?? '',
                  bathrooms: houseData['numBathrooms'] ?? 0,
                );
              },
            );
          },
        ),
      ),
    );
  }










 Query _buildQuery() {
  Query query = firestore.collectionGroup('houses');
  if (selectedSortOrder == 'lowToHigh') {
    query = query.orderBy('price', descending: false);
  } else if (selectedSortOrder == 'highToLow') {
    query = query.orderBy('price', descending: true);
  }
  return query;
}


  Future<void> _createFirestoreIndex() async {
    await firestore.collectionGroup('houses').get(); // Trigger an error to prompt index creation
  }

  @override
  void initState() {
    super.initState();
    // Create Firestore index when the widget initializes
    _createFirestoreIndex();
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
                      FaIcon(
                        FontAwesomeIcons.toilet,
                        color: Colors.black,
                        size: 20,
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

class DisplayHouseDetailPage extends StatelessWidget {
  final HouseDetails houseDetails;

  const DisplayHouseDetailPage({required this.houseDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(houseDetails.houseName),
      ),
      body: Center(
        child: Text('Details of ${houseDetails.houseName}'),
      ),
    );
  }
}

class HouseDetails {
  final String houseName;
  final double housePrice;
  final int occupants;
  final int rooms;
  final List<String> imageUrls;
  final String gender;
  final String email;
  final String userId;
  final int bathrooms;

  HouseDetails({
    required this.houseName,
    required this.housePrice,
    required this.occupants,
    required this.rooms,
    required this.imageUrls,
    required this.gender,
    required this.email,
    required this.userId,
    required this.bathrooms,});}
    */

    
















/*code with no error but no house appear


    import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({Key? key}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedSortOrder;
  String? selectedGender;
  int? selectedNumBathrooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Houses'),
        actions: <Widget>[
          DropdownButton<String>(
            value: selectedSortOrder,
            hint: Text('Sort by Price'),
            items: [
              DropdownMenuItem(value: 'lowToHigh', child: Text('Low to High')),
              DropdownMenuItem(value: 'highToLow', child: Text('High to Low')),
            ],
            onChanged: (value) {
              setState(() {
                selectedSortOrder = value;
              });
            },
          ),
          DropdownButton<String>(
            value: selectedGender,
            hint: Text('Filter by Gender'),
            items: [
              DropdownMenuItem(value: 'male', child: Text('Male')),
              DropdownMenuItem(value: 'female', child: Text('Female')),
              DropdownMenuItem(value: 'any', child: Text('Any')),
            ],
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),
          DropdownButton<int>(
            value: selectedNumBathrooms,
            hint: Text('Filter by Bathrooms'),
            items: [
              DropdownMenuItem(value: 1, child: Text('1 Bathroom')),
              DropdownMenuItem(value: 2, child: Text('2 Bathrooms')),
              DropdownMenuItem(value: 3, child: Text('3 Bathrooms')),
              // Add more options as needed
            ],
            onChanged: (value) {
              setState(() {
                selectedNumBathrooms = value;
              });
            },
          ),
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
          stream: _buildQuery().snapshots(),
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
                final houseData = houseDocs[index].data() as Map<String, dynamic>;
                final List<String> imageUrls = List<String>.from(houseData['imageUrls'] ?? []);
                return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: houseData['price']?.toDouble() ?? 0.0,
                  occupants: houseData['numOccupants'] ?? 0,
                  rooms: houseData['numRooms'] ?? 0,
                  imageUrls: imageUrls,
                  userId: houseData['userId'] ?? '',
                  gender: houseData['gender'] ?? '',
                  email: houseData['email'] ?? '',
                  bathrooms: houseData['numBathrooms'] ?? 0,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Query _buildQuery() {
    Query query = firestore.collection('houses');

    if (selectedSortOrder == 'lowToHigh') {
      query = query.orderBy('price', descending: false);
    } else if (selectedSortOrder == 'highToLow') {
      query = query.orderBy('price', descending: true);
    }

    if (selectedGender != null && selectedGender != 'any') {
      query = query.where('gender', isEqualTo: selectedGender);
    }

    if (selectedNumBathrooms != null) {
      query = query.where('numBathrooms', isEqualTo: selectedNumBathrooms);
    }

    return query;
  }



Future<void> _createFirestoreIndex() async {
  try {
    await firestore.collection('houses').get();
  } catch (error) {
    // Handle potential errors during index creation
    print("Error creating index: $error");
  }
}






  @override
  void initState() {
    super.initState();
    // Create Firestore index when the widget initializes
    _createFirestoreIndex();
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
                      FaIcon(
                        FontAwesomeIcons.toilet,
                        color: Colors.black,
                        size: 20,
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

class DisplayHouseDetailPage extends StatelessWidget {
  final HouseDetails houseDetails;

  const DisplayHouseDetailPage({required this.houseDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(houseDetails.houseName),
      ),
      body: Center(
        child: Text('Details of ${houseDetails.houseName}'),
      ),
    );
  }
}

class HouseDetails {
  final String houseName;
  final double housePrice;
  final int occupants;
  final int rooms;
  final List<String> imageUrls;
  final String gender;
  final String email;
  final String userId;
  final int bathrooms;

  HouseDetails({
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
}

*/


























/*appear no house for all


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({Key? key}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedSortOrder;
  String? selectedGender;
  int? selectedNumBathrooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Houses'),
        actions: <Widget>[
          DropdownButton<String>(
            value: selectedSortOrder,
            hint: Text('Sort by Price'),
            items: [
              DropdownMenuItem(value: 'lowToHigh', child: Text('Low to High')),
              DropdownMenuItem(value: 'highToLow', child: Text('High to Low')),
            ],
            onChanged: (value) {
              setState(() {
                selectedSortOrder = value;
              });
            },
          ),
          DropdownButton<String>(
            value: selectedGender,
            hint: Text('Filter by Gender'),
            items: [
              DropdownMenuItem(value: 'male', child: Text('Male')),
              DropdownMenuItem(value: 'female', child: Text('Female')),
              DropdownMenuItem(value: 'any', child: Text('Any')),
            ],
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),
          DropdownButton<int>(
            value: selectedNumBathrooms,
            hint: Text('Filter by Bathrooms'),
            items: [
              DropdownMenuItem(value: 1, child: Text('1 Bathroom')),
              DropdownMenuItem(value: 2, child: Text('2 Bathrooms')),
              DropdownMenuItem(value: 3, child: Text('3 Bathrooms')),
            ],
            onChanged: (value) {
              setState(() {
                selectedNumBathrooms = value;
              });
            },
          ),
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
          stream: _buildQuery().snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final List<DocumentSnapshot> houseDocs = snapshot.data!.docs;
            if (houseDocs.isEmpty) {
              return Center(child: Text('No houses found'));
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              itemCount: houseDocs.length,
              itemBuilder: (context, index) {
                final houseData = houseDocs[index].data() as Map<String, dynamic>;
                final List<String> imageUrls = List<String>.from(houseData['imageUrls'] ?? []);
                return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: houseData['price']?.toDouble() ?? 0.0,
                  occupants: houseData['numOccupants'] ?? 0,
                  rooms: houseData['numRooms'] ?? 0,
                  imageUrls: imageUrls,
                  userId: houseData['userId'] ?? '',
                  gender: houseData['gender'] ?? '',
                  email: houseData['email'] ?? '',
                  bathrooms: houseData['numBathrooms'] ?? 0,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Query _buildQuery() {
    Query query = firestore.collection('houses');

    if (selectedSortOrder == 'lowToHigh') {
      query = query.orderBy('price', descending: false);
    } else if (selectedSortOrder == 'highToLow') {
      query = query.orderBy('price', descending: true);
    }

    if (selectedGender != null && selectedGender != 'any') {
      query = query.where('gender', isEqualTo: selectedGender);
    }

    if (selectedNumBathrooms != null) {
      query = query.where('numBathrooms', isEqualTo: selectedNumBathrooms);
    }

    return query;
  }

  @override
  void initState() {
    super.initState();
    _createFirestoreIndex();
  }

  Future<void> _createFirestoreIndex() async {
    try {
      await firestore.collection('houses').get();
    } catch (error) {
      print("Error creating index: $error");
    }
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
                      FaIcon(
                        FontAwesomeIcons.toilet,
                        color: Colors.black,
                        size: 20,
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

class DisplayHouseDetailPage extends StatelessWidget {
  final HouseDetails houseDetails;

  const DisplayHouseDetailPage({required this.houseDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(houseDetails.houseName),
      ),
      body: Center(
        child: Text('Details of ${houseDetails.houseName}'),
      ),
    );
  }
}

class HouseDetails {
  final String houseName;
  final double housePrice;
  final int occupants;
  final int rooms;
  final List<String> imageUrls;
  final String gender;
  final String email;
  final String userId;
  final int bathrooms;

  HouseDetails({
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
}
*/








/*the first correct



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({Key? key}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedSortOrder;
  String? selectedGender;
  int? selectedNumBathrooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Houses'),
        actions: <Widget>[
          DropdownButton<String>(
            value: selectedSortOrder,
            hint: Text('Sort by Price'),
            items: [
              DropdownMenuItem(value: 'lowToHigh', child: Text('Low to High')),
              DropdownMenuItem(value: 'highToLow', child: Text('High to Low')),
            ],
            onChanged: (value) {
              setState(() {
                selectedSortOrder = value;
              });
            },
          ),
          DropdownButton<String>(
            value: selectedGender,
            hint: Text('Filter by Gender'),
            items: [
              DropdownMenuItem(value: 'male', child: Text('Male')),
              DropdownMenuItem(value: 'female', child: Text('Female')),
              DropdownMenuItem(value: 'any', child: Text('Any')),
            ],
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),
          DropdownButton<int>(
            value: selectedNumBathrooms,
            hint: Text('Filter by Bathrooms'),
            items: [
              DropdownMenuItem(value: 1, child: Text('1 Bathroom')),
              DropdownMenuItem(value: 2, child: Text('2 Bathrooms')),
              DropdownMenuItem(value: 3, child: Text('3 Bathrooms')),
            ],
            onChanged: (value) {
              setState(() {
                selectedNumBathrooms = value;
              });
            },
          ),
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
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: _fetchHouses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final List<DocumentSnapshot> houseDocs = snapshot.data ?? [];
            if (houseDocs.isEmpty) {
              return Center(child: Text('No houses found'));
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              itemCount: houseDocs.length,
              itemBuilder: (context, index) {
                final houseData = houseDocs[index].data() as Map<String, dynamic>;
                final List<String> imageUrls = List<String>.from(houseData['imageUrls'] ?? []);
                return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: houseData['price']?.toDouble() ?? 0.0,
                  occupants: houseData['numOccupants'] ?? 0,
                  rooms: houseData['numRooms'] ?? 0,
                  imageUrls: imageUrls,
                  userId: houseData['userId'] ?? '',
                  gender: houseData['gender'] ?? '',
                  email: houseData['email'] ?? '',
                  bathrooms: houseData['numBathrooms'] ?? 0,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<DocumentSnapshot>> _fetchHouses() async {
    QuerySnapshot userSnapshot = await firestore.collection('users').get();
    List<DocumentSnapshot> allHouses = [];

    for (var userDoc in userSnapshot.docs) {
      Query houseQuery = userDoc.reference.collection('houses');

      if (selectedSortOrder == 'lowToHigh') {
        houseQuery = houseQuery.orderBy('price', descending: false);
      } else if (selectedSortOrder == 'highToLow') {
        houseQuery = houseQuery.orderBy('price', descending: true);
      }

      if (selectedGender != null && selectedGender != 'any') {
        houseQuery = houseQuery.where('gender', isEqualTo: selectedGender);
      }

      if (selectedNumBathrooms != null) {
        houseQuery = houseQuery.where('numBathrooms', isEqualTo: selectedNumBathrooms);
      }

      QuerySnapshot houseSnapshot = await houseQuery.get();
      allHouses.addAll(houseSnapshot.docs);
    }

    return allHouses;
  }

  @override
  void initState() {
    super.initState();
    _createFirestoreIndex();
  }

  Future<void> _createFirestoreIndex() async {
    try {
      await firestore.collection('users').get();
    } catch (error) {
      print("Error creating index: $error");
    }
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
                      FaIcon(
                        FontAwesomeIcons.toilet,
                        color: Colors.black,
                        size: 20,
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

class DisplayHouseDetailPage extends StatelessWidget {
  final HouseDetails houseDetails;

  const DisplayHouseDetailPage({required this.houseDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(houseDetails.houseName),
      ),
      body: Center(
        child: Text('Details of ${houseDetails.houseName}'),
      ),
    );
  }
}

class HouseDetails {
  final String houseName;
  final double housePrice;
  final int occupants;
  final int rooms;
  final List<String> imageUrls;
  final String gender;
  final String email;
  final String userId;
  final int bathrooms;

  HouseDetails({
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
}
*/









/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({Key? key}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedSortOrder;
  String? selectedGender;
  int? selectedNumBathrooms;
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Houses'),
        actions: <Widget>[
          DropdownButton<String>(
            value: selectedSortOrder,
            hint: Text('Sort by Price'),
            items: [
              DropdownMenuItem(value: 'lowToHigh', child: Text('Low to High')),
              DropdownMenuItem(value: 'highToLow', child: Text('High to Low')),
            ],
            onChanged: (value) {
              setState(() {
                selectedSortOrder = value;
              });
            },
          ),
          DropdownButton<String>(
            value: selectedGender,
            hint: Text('Filter by Gender'),
            items: [
              DropdownMenuItem(value: 'male', child: Text('Male')),
              DropdownMenuItem(value: 'female', child: Text('Female')),
              DropdownMenuItem(value: 'any', child: Text('Any')),
            ],
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),
          DropdownButton<int>(
            value: selectedNumBathrooms,
            hint: Text('Filter by Bathrooms'),
            items: [
              DropdownMenuItem(value: 1, child: Text('1 Bathroom')),
              DropdownMenuItem(value: 2, child: Text('2 Bathrooms')),
              DropdownMenuItem(value: 3, child: Text('3 Bathrooms')),
            ],
            onChanged: (value) {
              setState(() {
                selectedNumBathrooms = value;
              });
            },
          ),
          Row(
            children: [
              Checkbox(
                value: showAll,
                onChanged: (value) {
                  setState(() {
                    showAll = value!;
                  });
                },
              ),
              Text('Show All'),
            ],
          ),
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
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: _fetchHouses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final List<DocumentSnapshot> houseDocs = snapshot.data ?? [];
            if (houseDocs.isEmpty) {
              return Center(child: Text('No houses found'));
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              itemCount: houseDocs.length,
              itemBuilder: (context, index) {
                final houseData = houseDocs[index].data() as Map<String, dynamic>;
                final List<String> imageUrls = List<String>.from(houseData['imageUrls'] ?? []);
                return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: houseData['price']?.toDouble() ?? 0.0,
                  occupants: houseData['numOccupants'] ?? 0,
                  rooms: houseData['numRooms'] ?? 0,
                  imageUrls: imageUrls,
                  userId: houseData['userId'] ?? '',
                  gender: houseData['gender'] ?? '',
                  email: houseData['email'] ?? '',
                  bathrooms: houseData['numBathrooms'] ?? 0,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<DocumentSnapshot>> _fetchHouses() async {
    QuerySnapshot userSnapshot = await firestore.collection('users').get();
    List<DocumentSnapshot> allHouses = [];

    for (var userDoc in userSnapshot.docs) {
      Query houseQuery = userDoc.reference.collection('houses');

      if (selectedSortOrder == 'lowToHigh') {
        houseQuery = houseQuery.orderBy('price', descending: false);
      } else if (selectedSortOrder == 'highToLow') {
        houseQuery = houseQuery.orderBy('price', descending: true);
      }

      if (!showAll) {
        if (selectedGender != null && selectedGender != 'any') {
          houseQuery = houseQuery.where('gender', isEqualTo: selectedGender);
        }

        if (selectedNumBathrooms != null) {
          houseQuery = houseQuery.where('numBathrooms', isEqualTo: selectedNumBathrooms);
        }
      }

      QuerySnapshot houseSnapshot = await houseQuery.get();
      allHouses.addAll(houseSnapshot.docs);
    }

    return allHouses;
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
                      FaIcon(
                        FontAwesomeIcons.toilet,
                        color: Colors.black,
                        size: 20,
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

class DisplayHouseDetailPage extends StatelessWidget {
  final HouseDetails houseDetails;

  const DisplayHouseDetailPage({required this.houseDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(houseDetails.houseName),
      ),
      body: Center(
        child: Text('Details of ${houseDetails.houseName}'),
      ),
    );
  }
}

class HouseDetails {
  final String houseName;
  final double housePrice;
  final int occupants;
  final int rooms;
  final List<String> imageUrls;
  final String gender;
  final String email;
  final String userId;
  final int bathrooms;

  HouseDetails({
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
}


*/














/*

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({Key? key}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedSortOrder;
  String? selectedGender;
  int? selectedNumBathrooms;
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Houses'),
        actions: <Widget>[
          DropdownButton<String>(
            value: selectedSortOrder,
            hint: Text('Sort by Price'),
            items: [
              DropdownMenuItem(value: 'lowToHigh', child: Text('Low to High')),
              DropdownMenuItem(value: 'highToLow', child: Text('High to Low')),
            ],
            onChanged: (value) {
              setState(() {
                selectedSortOrder = value;
              });
            },
          ),
          DropdownButton<String>(
            value: selectedGender,
            hint: Text('Filter by Gender'),
            items: [
              DropdownMenuItem(value: 'male', child: Text('Male')),
              DropdownMenuItem(value: 'female', child: Text('Female')),
              DropdownMenuItem(value: 'any', child: Text('Any')),
            ],
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),
          DropdownButton<int>(
            value: selectedNumBathrooms,
            hint: Text('Filter by Bathrooms'),
            items: [
              DropdownMenuItem(value: 1, child: Text('1 Bathroom')),
              DropdownMenuItem(value: 2, child: Text('2 Bathrooms')),
              DropdownMenuItem(value: 3, child: Text('3 Bathrooms')),
            ],
            onChanged: (value) {
              setState(() {
                selectedNumBathrooms = value;
              });
            },
          ),
          Row(
            children: [
              Checkbox(
                value: showAll,
                onChanged: (value) {
                  setState(() {
                    showAll = value!;
                  });
                },
              ),
              Text('Show All'),
            ],
          ),
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
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: _fetchHouses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final List<DocumentSnapshot> houseDocs = snapshot.data ?? [];
            if (houseDocs.isEmpty) {
              return Center(child: Text('No houses found'));
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              itemCount: houseDocs.length,
              itemBuilder: (context, index) {
                final houseData = houseDocs[index].data() as Map<String, dynamic>;
                final List<String> imageUrls = List<String>.from(houseData['imageUrls'] ?? []);
                return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: houseData['price']?.toDouble() ?? 0.0,
                  occupants: houseData['numOccupants'] ?? 0,
                  rooms: houseData['numRooms'] ?? 0,
                  imageUrls: imageUrls,
                  userId: houseData['userId'] ?? '',
                  gender: houseData['gender'] ?? '',
                  email: houseData['email'] ?? '',
                  bathrooms: houseData['numBathrooms'] ?? 0,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<DocumentSnapshot>> _fetchHouses() async {
    QuerySnapshot userSnapshot = await firestore.collection('users').get();
    List<DocumentSnapshot> allHouses = [];

    for (var userDoc in userSnapshot.docs) {
      Query houseQuery = userDoc.reference.collection('houses');

      if (selectedSortOrder == 'lowToHigh') {
        houseQuery = houseQuery.orderBy('price', descending: false);
      } else if (selectedSortOrder == 'highToLow') {
        houseQuery = houseQuery.orderBy('price', descending: true);
      }

      if (!showAll) {
        if (selectedGender != null && selectedGender != 'any') {
          houseQuery = houseQuery.where('gender', isEqualTo: selectedGender);
        }

        if (selectedNumBathrooms != null) {
          houseQuery = houseQuery.where('numBathrooms', isEqualTo: selectedNumBathrooms);
        }
      }

      QuerySnapshot houseSnapshot = await houseQuery.get();
      allHouses.addAll(houseSnapshot.docs);
    }

    return allHouses;
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
                children:[
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
                      FaIcon(
                        FontAwesomeIcons.toilet,
                        color: Colors.black,
                        size: 20,
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

class DisplayHouseDetailPage extends StatelessWidget {
  final HouseDetails houseDetails;

  const DisplayHouseDetailPage({required this.houseDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(houseDetails.houseName),
      ),
      body: Center(
        child: Text('Details of ${houseDetails.houseName}'),
      ),
    );
  }
}

class HouseDetails {
  final String houseName;
  final double housePrice;
  final int occupants;
  final int rooms;
  final List<String> imageUrls;
  final String gender;
  final String email;
  final String userId;
  final int bathrooms;

  HouseDetails({
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
}

*/














/*


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({Key? key}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  double? _minPrice;
  double? _maxPrice;
  String? _selectedGender;
  int? _selectedBathroom;

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Houses'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_alt),
            tooltip: 'Filter',
            onPressed: _showFilterDialog,
          ),
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
          stream: firestore.collectionGroup('houses').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final List<DocumentSnapshot> houseDocs = snapshot.data!.docs;
            final filteredHouseDocs = _filterHouses(houseDocs);

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredHouseDocs.length,
              itemBuilder: (context, index) {
                final houseData =
                    filteredHouseDocs[index].data() as Map<String, dynamic>;
                final List<String> imageUrls =
                    List<String>.from(houseData['imageUrls'] ?? []);
                return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: houseData['price'] ?? 0.0,
                  occupants: houseData['numOccupants'] ?? 0,
                  rooms: houseData['numRooms'] ?? 0,
                  imageUrls: imageUrls,
                  userId: houseData['userId'],
                  gender: houseData['gender'] ?? '',
                  email: houseData['email'] ?? '',
                  bathrooms: houseData['numBathrooms'] ?? 0,
                );
              },
            );
          },
        ),
      ),
    );
  }

  List<DocumentSnapshot> _filterHouses(List<DocumentSnapshot> houseDocs) {
    return houseDocs.where((house) {
      final houseData = house.data() as Map<String, dynamic>;

      // Apply price filter
      if (_minPrice != null &&
          houseData['price'] < _minPrice! ||
          _maxPrice != null &&
              houseData['price'] > _maxPrice!) {
        return false;
      }

      // Apply gender filter
      if (_selectedGender != null &&
          houseData['gender'] != _selectedGender) {
        return false;
      }

      // Apply bathroom filter
      if (_selectedBathroom != null &&
          houseData['numBathrooms'] != _selectedBathroom) {
        return false;
      }

      return true;
    }).toList();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filters'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Price Range'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Min'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _minPrice = value.isNotEmpty
                                ? double.parse(value)
                                : null;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Max'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _maxPrice = value.isNotEmpty
                                ? double.parse(value)
                                : null;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('Gender'),
                DropdownButton<String>(
                  value: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  items: <String>['Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Text('Number of Bathrooms'),
                DropdownButton<int>(
                  value: _selectedBathroom,
                  onChanged: (value) {
                    setState(() {
                      _selectedBathroom = value;
                    });
                  },
                  items: <int>[1, 2, 3, 4, 5]
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _minPrice = null;
                  _maxPrice = null;
                  _selectedGender = null;
                  _selectedBathroom = null;
                });
                Navigator.of(context).pop();
              },
              child: Text('Clear'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
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
                      Icon(
                        FontAwesomeIcons.toilet,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text('Bathrooms: $bathrooms'),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 4),
                      Text('Gender: $gender'),
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









import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/housedetailspage.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({Key? key}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  double? _minPrice;
  double? _maxPrice;
  String? _selectedGender;
  int? _selectedBathroom;

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Houses'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_alt),
            tooltip: 'Filter',
            onPressed: _showFilterDialog,
          ),
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
          stream: firestore.collectionGroup('houses').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final List<DocumentSnapshot> houseDocs = snapshot.data!.docs;
            final filteredHouseDocs = _filterHouses(houseDocs);

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1
                ,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredHouseDocs.length,
              itemBuilder: (context, index) {
                final houseData =
                    filteredHouseDocs[index].data() as Map<String, dynamic>;
                final List<String> imageUrls =
                    List<String>.from(houseData['imageUrls'] ?? []);
                return HouseItem(
                  houseName: houseData['houseName'] ?? '',
                  housePrice: houseData['price'] ?? 0.0,
                  occupants: houseData['numOccupants'] ?? 0,
                  rooms: houseData['numRooms'] ?? 0,
                  imageUrls: imageUrls,
                  userId: houseData['userId'],
                  gender: houseData['gender'] ?? '',
                  email: houseData['email'] ?? '',
                  bathrooms: houseData['numBathrooms'] ?? 0,
                );
              },
            );
          },
        ),
      ),
    );
  }

  List<DocumentSnapshot> _filterHouses(List<DocumentSnapshot> houseDocs) {
    return houseDocs.where((house) {
      final houseData = house.data() as Map<String, dynamic>;

      // Apply price filter
      if (_minPrice != null &&
          houseData['price'] < _minPrice! ||
          _maxPrice != null &&
              houseData['price'] > _maxPrice!) {
        return false;
      }

      // Apply gender filter
      if (_selectedGender != null &&
          houseData['gender'] != _selectedGender) {
        return false;
      }

      // Apply bathroom filter
      if (_selectedBathroom != null &&
          houseData['numBathrooms'] != _selectedBathroom) {
        return false;
      }

      return true;
    }).toList();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filters'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Price Range'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Min'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _minPrice = value.isNotEmpty
                                ? double.parse(value)
                                : null;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Max'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _maxPrice = value.isNotEmpty
                                ? double.parse(value)
                                : null;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('Gender'),
                DropdownButton<String>(
                  value: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  items: <String>['male', 'female', 'male and female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Text('Number of Bathrooms'),
                DropdownButton<int>(
                  value: _selectedBathroom,
                  onChanged: (value) {
                    setState(() {
                      _selectedBathroom = value;
                    });
                  },
                  items: <int>[1, 2, 3, 4, 5]
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _minPrice = null;
                  _maxPrice = null;
                  _selectedGender = null;
                  _selectedBathroom = null;
                });
                Navigator.of(context).pop();
              },
              child: Text('Clear'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
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
                      Icon(
                        FontAwesomeIcons.toilet,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text('Bathrooms: $bathrooms'),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 4),
                      Text('Gender: $gender'),
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
