/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:front/tout.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE6F3F3),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _getImage,
                      child: Container(
                        height: 120,
                        width: 120,
                        margin: const EdgeInsets.only(
                          top: 100,
                          bottom: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 2),
                              blurRadius: 10,
                            ),
                          ],
                          image: _image != null
                              ? DecorationImage(
                                  image: FileImage(_image!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _image == null
                            ? const Icon(
                                Icons.add_photo_alternate,
                                size: 40,
                              )
                            : null,
                      ),
                    ),
                    const Text(
                      "Maha",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      "computer science",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Color(0xFF111236),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 24,
                    right: 24,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "PROFILE",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Color(0xFF111236),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      listProfile(Icons.person, "Full Name", "Maha Ayman"),
                      /*listProfile(
                          Icons.date_range, "Date of Birth", "July 21, 2000"),*/

                      listProfile(Icons.email, "Email", "MAha@example.com"),
                      listProfile(Icons.female, "Gender", "Femal"),
                      listProfile(Icons.phone, "Phone Number", "5655956"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: Menu());
  }

  Widget listProfile(IconData icon, String text1, String text2) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  color: Color(0xFF111236),
                  fontFamily: "Montserrat",
                  fontSize: 14,
                ),
              ),
              Text(
                text2,
                style: const TextStyle(
                  color: Color(0xFF111236),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/

//this important
/*import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:front/tout.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late File _image;
  late String _defaultImage;
  bool _isImageChanged = false;

  @override
  void initState() {
    super.initState();
    _getDefaultImage().then((defaultImage) {
      setState(() {
        _defaultImage = defaultImage;
        _image = File(defaultImage);
      });
    });
  }

  Future<String> _getDefaultImage() async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(widget.userId);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final userData = snapshot.data() as Map<String, dynamic>;
      final gender = userData['gender'];
      if (gender != null) {
        // Use gender to determine default image path
        return _getImagePathBasedOnGender(gender);
      } else {
        // Handle case where gender is missing
        return 'images/default.jpg'; // Or provide a neutral image
      }
    } else {
      // Handle case where user data is not found
      print("Error: User data not found");
      return 'images/4.jpg'; // Or provide a neutral image
    }
  }

  String _getImagePathBasedOnGender(String gender) {
    if (gender == 'male') {
      return 'images/boy.jpg';
    } else {
      return 'images/girle.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F3F3),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>?;

          if (userData == null) {
            return Center(child: Text('User data not found'));
          }
          dynamic dateOfBirth = userData['Date of Birth'];
          if (dateOfBirth is Timestamp) {
            dateOfBirth = dateOfBirth.toDate();
          }

          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      GestureDetector(
                        //  onTap: _getImage,
                        child: Container(
                          height: 120,
                          width: 120,
                          margin: const EdgeInsets.only(
                            top: 100,
                            bottom: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(2, 2),
                                blurRadius: 10,
                              ),
                            ],
                            image: _image != null
                                ? DecorationImage(
                                    image: FileImage(_image),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _image == null
                              ? const Icon(
                                  Icons.add_photo_alternate,
                                  size: 40,
                                )
                              : null,
                        ),
                      ),
                      Text(
                        userData['Full name'] ?? '',
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        userData['major'] ?? '',
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          color: Color(0xFF111236),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 24,
                      right: 24,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "PROFILE",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Color(0xFF111236),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        listProfile(
                            Icons.person, "Full Name", userData['Full name']),
                        /*listProfile(
                            Icons.date_range, "Date of Birth", dateOfBirth),*/
                        listProfile(
                            Icons.email, "Email", "MAha2002@example.com"),
                        listProfile(Icons.female, "Gender", userData['gender']),
                        listProfile(Icons.phone, "Phone Number", "5655956"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      drawer: Menu(),
    );
  }

  Widget listProfile(IconData icon, String text1, String text2) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  color: Color(0xFF111236),
                  fontFamily: "Montserrat",
                  fontSize: 14,
                ),
              ),
              Text(
                text2,
                style: const TextStyle(
                  color: Color(0xFF111236),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/
/*import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:front/tout.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late File _image;
  late String _defaultImage;
  bool _isImageChanged = false;

  @override
  void initState() {
    super.initState();
    _getDefaultImage().then((defaultImage) {
      setState(() {
        _defaultImage = defaultImage;
        _image = File(defaultImage);
      });
    });
  }

  Future<String> _getDefaultImage() async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(widget.userId);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final userData = snapshot.data() as Map<String, dynamic>;
      final gender = userData['gender'];
      if (gender != null) {
        return _getImagePathBasedOnGender(gender);
      } else {
        return 'images/default.jpg';
      }
    } else {
      print("Error: User data not found");
      return 'images/default.jpg';
    }
  }

  String _getImagePathBasedOnGender(String gender) {
    if (gender == 'male') {
      return 'images/boy.jpg';
    } else {
      return 'images/girle.jpg';
    }
  }

  Future<void> _uploadImage(File image) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('${widget.userId}.jpg');
    await storageRef.putFile(image);
    final imageUrl = await storageRef.getDownloadURL();

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(widget.userId);
    await userRef.update({'image_url': imageUrl});

    setState(() {
      _isImageChanged = true;
    });
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _uploadImage(_image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F3F3),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>?;

          if (userData == null) {
            return Center(child: Text('User data not found'));
          }
          dynamic dateOfBirth = userData['Date of Birth'];
          if (dateOfBirth is Timestamp) {
            dateOfBirth = dateOfBirth.toDate();
          }

          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _getImage(ImageSource.gallery),
                        child: Container(
                          height: 120,
                          width: 120,
                          margin: const EdgeInsets.only(
                            top: 100,
                            bottom: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(2, 2),
                                blurRadius: 10,
                              ),
                            ],
                            image: _image != null
                                ? DecorationImage(
                                    image: FileImage(_image),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _image == null
                              ? const Icon(
                                  Icons.add_photo_alternate,
                                  size: 40,
                                )
                              : null,
                        ),
                      ),
                      Text(
                        userData['Full name'] ?? '',
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        userData['major'] ?? '',
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          color: Color(0xFF111236),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 24,
                      right: 24,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "PROFILE",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Color(0xFF111236),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        listProfile(
                            Icons.person, "Full Name", userData['Full name']),
                        /*listProfile(
                            Icons.date_range, "Date of Birth", dateOfBirth),*/
                        listProfile(
                            Icons.email, "Email", "MAha2002@example.com"),
                        listProfile(Icons.female, "Gender", userData['gender']),
                        listProfile(Icons.phone, "Phone Number", "5655956"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      drawer: Menu(),
    );
  }

  Widget listProfile(IconData icon, String text1, String text2) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  color: Color(0xFF111236),
                  fontFamily: "Montserrat",
                  fontSize: 14,
                ),
              ),
              Text(
                text2,
                style: const TextStyle(
                  color: Color(0xFF111236),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:front/tout.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late File _image;
  late String _defaultImage;
  bool _isImageChanged = false;

  @override
  /* void initState() {
    super.initState();
    _getDefaultImage().then((defaultImage) {
      setState(() {
        _defaultImage = defaultImage;
        _image = File(defaultImage);
      });
    });
  }

  Future<String> _getDefaultImage() async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(widget.userId);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final userData = snapshot.data() as Map<String, dynamic>;
      final gender = userData['gender'];
      if (gender != null) {
        return _getImagePathBasedOnGender(gender);
      } else {
        return 'assets/images/boy.jpg';
      }
    } else {
      print("Error: User data not found");
      return 'assets/images/boy.jpg';
    }
  }

  String _getImagePathBasedOnGender(String gender) {
    /*  if (gender == 'male') {
      return 'assets/images/boy.jpg';
    } else {
      return 'assets/images/girle.jpg';
    }*/
    return 'assets/images/boy.jpg';
  }

  Future<void> _uploadImage(File image) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('${widget.userId}.jpg');
    await storageRef.putFile(image);
    final imageProfile = await storageRef.getDownloadURL();

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(widget.userId);
    await userRef.update({'imageProfile': imageProfile});

    setState(() {
      _isImageChanged = true;
    });
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _uploadImage(_image);
      });
    }
  }*/
  @override
  void initState() {
    super.initState();
    _getDefaultImage().then((defaultImage) {
      setState(() {
        _defaultImage = defaultImage;
        if (!_isImageChanged) {
          _image = File(defaultImage);
        }
      });
    });
  }

  Future<String> _getDefaultImage() async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(widget.userId);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final userData = snapshot.data() as Map<String, dynamic>;
      final gender = userData['gender'];
      if (gender != null) {
        return _getImagePathBasedOnGender(gender);
      }
    }
    return 'images/imageicon.png';
  }

  Future<void> _uploadImage(File image) async {
    if (_isImageChanged) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${widget.userId}.jpg');
      await storageRef.putFile(image);
      final imageProfile = await storageRef.getDownloadURL();

      final userRef =
          FirebaseFirestore.instance.collection('users').doc(widget.userId);
      await userRef.update({'imageProfile': imageProfile});
    }
  }

  String _getImagePathBasedOnGender(String gender) {
    if (gender == 'male') {
      return 'images/imageicon.png';
    } else {
      return 'images/imageicon.png';
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      try {
        final imageFile = File(pickedFile.path);
        if (!mounted) return;
        setState(() {
          _image = imageFile;
          _isImageChanged = true;
          _uploadImage(_image);
        });
      } catch (e) {
        print('Error selecting image: $e');
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F3F3),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>?;

          if (userData == null) {
            return Center(child: Text('User data not found'));
          }
          dynamic dateOfBirth = userData['Date of Birth'];
          if (dateOfBirth is Timestamp) {
            dateOfBirth = dateOfBirth.toDate();
          }

          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _getImage(ImageSource.gallery),
                        child: Container(
                          height: 120,
                          width: 120,
                          margin: const EdgeInsets.only(
                            top: 100,
                            bottom: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(2, 2),
                                blurRadius: 10,
                              ),
                            ],
                            image: _image != null
                                ? DecorationImage(
                                    image: FileImage(_image),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _image == null
                              ? const Icon(
                                  Icons.add_photo_alternate,
                                  size: 40,
                                )
                              : null,
                        ),
                      ),
                      Text(
                        userData['Full name'] ?? '',
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        userData['major'] ?? '',
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          color: Color(0xFF111236),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 24,
                      right: 24,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "PROFILE",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Color(0xFF111236),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        listProfile(
                            Icons.person, "Full Name", userData['Full name']),
                        /*listProfile(
                            Icons.date_range, "Date of Birth", dateOfBirth),*/
                        listProfile(
                            Icons.email, "Email", "MAha2002@example.com"),
                        listProfile(Icons.female, "Gender", userData['gender']),
                        listProfile(Icons.phone, "Phone Number", "5655956"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      drawer: Menu(),
    );
  }

  Widget listProfile(IconData icon, String text1, String text2) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  color: Color(0xFF111236),
                  fontFamily: "Montserrat",
                  fontSize: 14,
                ),
              ),
              Text(
                text2,
                style: const TextStyle(
                  color: Color(0xFF111236),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
