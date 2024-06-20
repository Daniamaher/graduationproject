/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Housing/pages/edithousepage.dart';
import 'package:flutter_application_1/constant.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Housing/pages/edithousepage.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayHouseDetailPage extends StatefulWidget {
  final HouseDetails houseDetails;

  DisplayHouseDetailPage({required this.houseDetails});

  @override
  _DisplayHouseDetailPageState createState() => _DisplayHouseDetailPageState();
}

class _DisplayHouseDetailPageState extends State<DisplayHouseDetailPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
final double latitude = widget.houseDetails.latitude;
final double longitude = widget.houseDetails.longitude;


        final double latitude = houseData['latitude'] is int
            ? (houseData['latitude'] as int).toDouble()
            : (houseData['latitude'] ?? 0.0).toDouble();
        final double longitude = houseData['longitude'] is int
            ? (houseData['longitude'] as int).toDouble()
            : (houseData['longitude'] ?? 0.0).toDouble();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(widget.houseDetails.houseName,
            style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          if (user != null && widget.houseDetails.userId == user.uid)
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditHousePage(
                      userId: widget.houseDetails.userId,
                      houseData: {
                        'houseName': widget.houseDetails.houseName,
                        'price': widget.houseDetails.housePrice.toDouble(),
                        'numRooms': widget.houseDetails.rooms,
                        'numBathrooms': widget.houseDetails.bathrooms,
                        'gender': widget.houseDetails.gender,
                        'numOccupants': widget.houseDetails.occupants,
                        'email': widget.houseDetails.email,
                        'imageUrls': widget.houseDetails.imageUrls,
                        'latitude':widget.houseDetails.latitude , longitude: houseData['longitude'], location: houseData['location']??'',
                      },
                    ),
                  ),
                );
              },
            ),
          if (user != null && widget.houseDetails.userId == user.uid)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content:
                          Text('Are you sure you want to delete this house?'),
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
                              CollectionReference housesCollection =
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.houseDetails.userId)
                                      .collection('houses');

                              QuerySnapshot querySnapshot =
                                  await housesCollection
                                      .where('houseName',
                                          isEqualTo:
                                              widget.houseDetails.houseName)
                                      .where('price',
                                          isEqualTo:
                                              widget.houseDetails.housePrice)
                                      .where('email',
                                          isEqualTo: widget.houseDetails.email)
                                      .get();

                              if (querySnapshot.docs.isNotEmpty) {
                                await housesCollection
                                    .doc(querySnapshot.docs.first.id)
                                    .delete();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('House deleted successfully'),
                                  ),
                                );

                                Navigator.pop(context); // Close the dialog
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('No matching house found'),
                                  ),
                                );
                              }
                            } catch (e) {
                              print('Error deleting house: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Failed to delete house. Please try again later.'),
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
            SizedBox(height: 10),
            // Display images
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.houseDetails.imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      widget.houseDetails.imageUrls[index],
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.people, color: kPrimaryColor),
              title: Text('Occupants: ${widget.houseDetails.occupants}'),
            ),
            ListTile(
              leading: Icon(Icons.bathtub, color: kPrimaryColor),
              title: Text('Bathrooms: ${widget.houseDetails.bathrooms}'),
            ),
            ListTile(
              leading: Icon(Icons.home, color: kPrimaryColor),
              title: Text('Rooms: ${widget.houseDetails.rooms}'),
            ),
            ListTile(
              leading: Icon(Icons.person, color: kPrimaryColor),
              title: Text('Gender: ${widget.houseDetails.gender}'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: kPrimaryColor),
              title: Text('Email: ${widget.houseDetails.email}'),
              onTap: () => _launchEmail(widget.houseDetails.email),
            ),
             const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(latitude, longitude),
                        zoom: 14,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId('voteLocation'),
                          position: LatLng(latitude, longitude),
                        ),
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddReviewDialog(houseDetails: widget.houseDetails);
                    },
                  );
                },
                child: Text('Add Review'),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.houseDetails.userId)
                  .collection('houses')
                  .doc(widget.houseDetails.houseId)
                  .collection('reviews')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No reviews yet.'));
                }

                final reviews = snapshot.data!.docs.map((doc) {
                  final reviewData = doc.data() as Map<String, dynamic>;
                  return Review(
                    id: doc.id,
                    userId: reviewData['userId'] ?? '',
                    email: reviewData['email'] ?? '',
                    rating: reviewData['rating'] ?? 0,
                    comment: reviewData['comment'] ?? '',
                    timestamp: reviewData['timestamp'] ?? Timestamp.now(),
                  );
                }).toList();

                double averageRating =
                    reviews.fold(0, (sum, review) => sum + review.rating) /
                        reviews.length;
                int fullStars = averageRating.floor();
                bool hasHalfStar = averageRating - fullStars >= 0.5;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        fullStars,
                        (index) => Icon(Icons.star, color: Colors.yellow),
                      )..addAll(
                          [
                            if (hasHalfStar)
                              Icon(Icons.star_half, color: Colors.yellow),
                            for (int i = 0;
                                i < 5 - fullStars - (hasHalfStar ? 1 : 0);
                                i++)
                              Icon(Icons.star_border, color: Colors.yellow),
                          ],
                        ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        final isOwnReview =
                            user != null && review.userId == user.uid;
                        return Card(
                          elevation: 3,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: ListTile(
                            title: Text(review.comment),
                            subtitle: Text(
                                'Rating: ${review.rating}\nBy: ${review.email}'),
                            trailing: isOwnReview
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return EditReviewDialog(
                                                  houseDetails:
                                                      widget.houseDetails,
                                                  review: review);
                                            },
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(widget.houseDetails.userId)
                                              .collection('houses')
                                              .doc(widget.houseDetails.houseId)
                                              .collection('reviews')
                                              .doc(review.id)
                                              .delete();
                                        },
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }
}

class Review {
  final String id;
  final String userId;
  final String email;
  final int rating;
  final String comment;
  final Timestamp timestamp;

  Review({
    required this.id,
    required this.userId,
    required this.email,
    required this.rating,
    required this.comment,
    required this.timestamp,
  });

  factory Review.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Review(
      id: doc.id,
      userId: data['userId'] ?? '',
      email: data['email'] ?? '',
      rating: data['rating'] ?? 0,
      comment: data['comment'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'email': email,
      'rating': rating,
      'comment': comment,
      'timestamp': timestamp,
    };
  }
}

class HouseDetails {
  final String houseId;
  final String houseName;
  final double housePrice;
  final int occupants;
  final int rooms;
  final List<String> imageUrls;
  final String gender;
  final String email;
  final String userId;
  final int bathrooms;
final double latitude;
final double  longitude;
final String location;
  HouseDetails(this.latitude, this.longitude, this.location, {
    required this.houseId,
    required this.houseName,
    required this.housePrice,
    required this.occupants,
    required this.rooms,
    required this.imageUrls,
    required this.gender,
    required this.email,
    required this.userId,
    required this.bathrooms, required this.latitude,
  });

  factory HouseDetails.defaultData() {
    return HouseDetails(
      houseId: 'defaultHouseId',
      houseName: 'Example House',
      imageUrls: [
        'https://via.placeholder.com/300',
        'https://via.placeholder.com/300',
        'https://via.placeholder.com/300',
      ],
      occupants: 4,
      bathrooms: 2,
      rooms: 3,
      gender: 'Any',
      email: 'example@example.com',
      userId: 'defaultUserId',
      housePrice: 0,


    );
  }
}

class AddReviewDialog extends StatefulWidget {
  final HouseDetails houseDetails;

  AddReviewDialog({required this.houseDetails});

  @override
  _AddReviewDialogState createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  int _rating = 1;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('You need to be logged in to submit a review.')));
        return;
      }
      final userEmail = user.email ?? 'unknown@example.com';
      final review = Review(
        id: '',
        userId: user.uid,
        email: userEmail,
        rating: _rating,
        comment: _commentController.text,
        timestamp: Timestamp.now(),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.houseDetails.userId)
          .collection('houses')
          .doc(widget.houseDetails.houseId)
          .collection('reviews')
          .add(review.toFirestore());

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Review submitted successfully.')));
      _commentController.clear();
      setState(() {
        _rating = 1;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: Text('Add a Review'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                value: _rating,
                decoration: InputDecoration(labelText: 'Rating'),
                items: List.generate(5, (index) => index + 1)
                    .map((rating) => DropdownMenuItem(
                          value: rating,
                          child: Text('$rating Star${rating > 1 ? 's' : ''}'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _rating = value!;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a rating' : null,
              ),
              TextFormField(
                controller: _commentController,
                decoration: InputDecoration(labelText: 'Comment'),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a comment' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _submitReview,
            child: Text('Submit Review'),
          ),
        ],
      ),
    );
  }
}

class EditReviewDialog extends StatefulWidget {
  final HouseDetails houseDetails;
  final Review review;

  EditReviewDialog({required this.houseDetails, required this.review});

  @override
  _EditReviewDialogState createState() => _EditReviewDialogState();
}

class _EditReviewDialogState extends State<EditReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _commentController;
  late int _rating;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController(text: widget.review.comment);
    _rating = widget.review.rating;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_formKey.currentState!.validate()) {
      final updatedReview = Review(
        id: widget.review.id,
        userId: widget.review.userId,
        email: widget.review.email,
        rating: _rating,
        comment: _commentController.text,
        timestamp: widget.review.timestamp,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.houseDetails.userId)
          .collection('houses')
          .doc(widget.houseDetails.houseId)
          .collection('reviews')
          .doc(widget.review.id)
          .set(updatedReview.toFirestore());

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Review updated successfully.')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: Text('Edit Review'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                value: _rating,
                decoration: InputDecoration(labelText: 'Rating'),
                items: List.generate(5, (index) => index + 1)
                    .map((rating) => DropdownMenuItem(
                          value: rating,
                          child: Text('$rating Star${rating > 1 ? 's' : ''}'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _rating = value!;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a rating' : null,
              ),
              TextFormField(
                controller: _commentController,
                decoration: InputDecoration(labelText: 'Comment'),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a comment' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _submitReview,
            child: Text('Update Review'),
          ),
        ],
      ),
    );
  }
}
*/









import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'edithousepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'House Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DisplayHouseDetailPage(
        houseDetails: HouseDetails(
          userId: 'user123',
          houseId: 'house123',
          houseName: 'Lovely House',
          housePrice: 1000,
          rooms: 3,
          bathrooms: 2,
          gender: 'Any',
          occupants: 4,
          email: 'owner@example.com',
          imageUrls: ['https://via.placeholder.com/150'],
          latitude: 37.7749,
          longitude: -122.4194,
          location: 'San Francisco, CA',
        ),
      ),
    );
  }
}

class DisplayHouseDetailPage extends StatefulWidget {
  final HouseDetails houseDetails;

  DisplayHouseDetailPage({required this.houseDetails});

  @override
  _DisplayHouseDetailPageState createState() => _DisplayHouseDetailPageState();
}

class _DisplayHouseDetailPageState extends State<DisplayHouseDetailPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final double latitude = widget.houseDetails.latitude;
    final double longitude = widget.houseDetails.longitude;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xff0f1035),
        title: Text(widget.houseDetails.houseName, style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          if (user != null && widget.houseDetails.userId == user.uid)
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditHousePage(
                      userId: widget.houseDetails.userId,
                      houseData: {
                        'houseName': widget.houseDetails.houseName,
                        'price': widget.houseDetails.housePrice,
                        'numRooms': widget.houseDetails.rooms,
                        'numBathrooms': widget.houseDetails.bathrooms,
                        'gender': widget.houseDetails.gender,
                        'numOccupants': widget.houseDetails.occupants,
                        'email': widget.houseDetails.email,
                        'imageUrls': widget.houseDetails.imageUrls,
                        'latitude': widget.houseDetails.latitude,
                        'longitude': widget.houseDetails.longitude,
                        'location': widget.houseDetails.location,
                      },
                    ),
                  ),
                );
              },
            ),
          if (user != null && widget.houseDetails.userId == user.uid)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () => _confirmDelete(context),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // Display images
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.houseDetails.imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      widget.houseDetails.imageUrls[index],
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            _buildInfoTile(Icons.people, 'Occupants: ${widget.houseDetails.occupants}'),
            _buildInfoTile(Icons.bathtub, 'Bathrooms: ${widget.houseDetails.bathrooms}'),
            _buildInfoTile(Icons.home, 'Rooms: ${widget.houseDetails.rooms}'),
            _buildInfoTile(Icons.person, 'Gender: ${widget.houseDetails.gender}'),
            _buildInfoTile(Icons.email, 'Email: ${widget.houseDetails.email}', onTap: () => _launchEmail(widget.houseDetails.email)),
            SizedBox(height: 10),
            _buildMap(latitude, longitude),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () => _showAddReviewDialog(context),
                child: Text('Add Review'),
              ),
            ),
            _buildReviewsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String text, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: kPrimaryColor),
      title: Text(text),
      onTap: onTap,
    );
  }

  Widget _buildMap(double latitude, double longitude) {
    return Container(
      width: double.infinity,
      height: 200,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: MarkerId('houseLocation'),
            position: LatLng(latitude, longitude),
          ),
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Are you sure you want to delete this house?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => _deleteHouse(),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteHouse() async {
    try {
      CollectionReference housesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.houseDetails.userId)
          .collection('houses');

      QuerySnapshot querySnapshot = await housesCollection
          .where('houseName', isEqualTo: widget.houseDetails.houseName)
          .where('price', isEqualTo: widget.houseDetails.housePrice)
          .where('email', isEqualTo: widget.houseDetails.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await housesCollection.doc(querySnapshot.docs.first.id).delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('House deleted successfully')),
        );

        Navigator.pop(context); // Close the dialog
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No matching house found')),
        );
      }
    } catch (e) {
      print('Error deleting house: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete house. Please try again later.')),
      );
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  void _showAddReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddReviewDialog(houseDetails: widget.houseDetails);
      },
    );
  }

  Widget _buildReviewsSection() {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.houseDetails.userId)
          .collection('houses')
          .doc(widget.houseDetails.houseId)
          .collection('reviews')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No reviews yet.'));
        }

        final reviews = snapshot.data!.docs.map((doc) {
          final reviewData = doc.data() as Map<String, dynamic>;
          return Review(
            id: doc.id,
            userId: reviewData['userId'] ?? '',
            email: reviewData['email'] ?? '',
            rating: reviewData['rating'] ?? 0,
            comment: reviewData['comment'] ?? '',
            timestamp: reviewData['timestamp'] ?? Timestamp.now(),
          );
        }).toList();

        double averageRating = reviews.fold(0, (sum, review) => sum + review.rating) / reviews.length;
        int fullStars = averageRating.floor();
        bool hasHalfStar = averageRating - fullStars >= 0.5;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                fullStars,
                (index) => Icon(Icons.star, color: Colors.yellow),
              )..addAll(
                [
                  if (hasHalfStar) Icon(Icons.star_half, color: Colors.yellow),
                  for (int i = 0; i < 5 - fullStars - (hasHalfStar ? 1 : 0); i++) Icon(Icons.star_border, color: Colors.yellow),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Card(
                  child: ListTile(
                    title: Text('Rating: ${review.rating}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Comment: ${review.comment}'),
                        Text('By: ${review.email}'),
                      ],
                    ),
                    trailing: user != null && review.userId == user.uid
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => _showEditReviewDialog(review),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _confirmDeleteReview(review),
                              ),
                            ],
                          )
                        : null,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditReviewDialog(Review review) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddReviewDialog(houseDetails: widget.houseDetails, review: review);
      },
    );
  }

  void _confirmDeleteReview(Review review) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Are you sure you want to delete this review?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => _deleteReview(review),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteReview(Review review) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      final reviewRef = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.houseDetails.userId)
          .collection('houses')
          .doc(widget.houseDetails.houseId)
          .collection('reviews')
          .doc(review.id);

      await reviewRef.delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review deleted successfully')),
      );
    } catch (e) {
      print('Error deleting review: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete review. Please try again later.')),
      );
    }
  }
}

class AddReviewDialog extends StatefulWidget {
  final HouseDetails houseDetails;
  final Review? review;

  AddReviewDialog({required this.houseDetails, this.review});

  @override
  _AddReviewDialogState createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  late int _rating;
  late String _comment;

  @override
  void initState() {
    super.initState();
    _rating = widget.review?.rating ?? 0;
    _comment = widget.review?.comment ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.review == null ? 'Add Review' : 'Edit Review'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _comment,
              decoration: InputDecoration(labelText: 'Comment'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a comment';
                }
                return null;
              },
              onSaved: (value) => _comment = value!,
            ),
            DropdownButtonFormField<int>(
              value: _rating,
              decoration: InputDecoration(labelText: 'Rating'),
              items: List.generate(5, (index) => index + 1)
                  .map((rating) => DropdownMenuItem(
                        child: Text(rating.toString()),
                        value: rating,
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _rating = value!),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _submitReview(),
          child: Text(widget.review == null ? 'Submit' : 'Update'),
        ),
      ],
    );
  }

  Future<void> _submitReview() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    final reviewRef = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.houseDetails.userId)
        .collection('houses')
        .doc(widget.houseDetails.houseId)
        .collection('reviews')
        .doc(widget.review?.id);

    final reviewData = {
      'userId': user.uid,
      'email': user.email,
      'rating': _rating,
      'comment': _comment,
      'timestamp': Timestamp.now(),
    };

    try {
      if (widget.review == null) {
        await reviewRef.set(reviewData);
      } else {
        await reviewRef.update(reviewData);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.review == null ? 'Review added' : 'Review updated')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      print('Error submitting review: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit review. Please try again later.')),
      );
    }
  }
}

class HouseDetails {
  final String userId;
  final String houseId;
  final String houseName;
  final double housePrice;
  final int rooms;
  final int bathrooms;
  final String gender;
  final int occupants;
  final String email;
  final List<String> imageUrls;
  final double latitude;
  final double longitude;
  final String location;

  HouseDetails({
    required this.userId,
    required this.houseId,
    required this.houseName,
    required this.housePrice,
    required this.rooms,
    required this.bathrooms,
    required this.gender,
    required this.occupants,
    required this.email,
    required this.imageUrls,
    required this.latitude,
    required this.longitude,
    required this.location,


});

factory HouseDetails.defaultData() {
    return HouseDetails(
      houseId: 'defaultHouseId',
      houseName: 'Example House',
      housePrice: 0.0, // Default value for house price
      imageUrls: [
        'https://via.placeholder.com/300',
        'https://via.placeholder.com/300',
        'https://via.placeholder.com/300',
      ],
      occupants: 4,
      bathrooms: 2,
      rooms: 3,
      gender: 'Any',
      email: 'example@example.com',
      userId: 'defaultUserId',
      latitude: 0.0,
      longitude: 0.0,
      location: 'Default Location',
    );
  }
}


class Review {
  final String id;
  final String userId;
  final String email;
  final int rating;
  final String comment;
  final Timestamp timestamp;

  Review({
    required this.id,
    required this.userId,
    required this.email,
    required this.rating,
    required this.comment,
    required this.timestamp,
  });
}

class EditHousePage extends StatelessWidget {
  final String userId;
  final Map<String, dynamic> houseData;

  EditHousePage({required this.userId, required this.houseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit House'),
      ),
      body: Center(
        child: Text('Edit house details here...'),
      ),
    );
  }
}

const kPrimaryColor = Color(0xff0f1035);
