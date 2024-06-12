/*import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/widgets/customTextField.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/map/markepmappage.dart';
import 'package:image_picker/image_picker.dart';

class AddHousePage extends StatefulWidget {
  @override
  _AddHousePageState createState() => _AddHousePageState();
}

class _AddHousePageState extends State<AddHousePage> {
  final TextEditingController houseNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController numRoomsController = TextEditingController();
  final TextEditingController numBathroomsController = TextEditingController();
  final TextEditingController numOccupantsController = TextEditingController();
  final locationController = TextEditingController();
  double? latitude;
  double? longitude;
  final FirestoreService firestoreService = FirestoreService();

  List<String> imageUrls = [];
  String? _selectedGender;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Add House',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'House Name',
                  controller: houseNameController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'House name is required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Price',
                  controller: priceController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Price is required';
                    } else if (double.tryParse(value!) == null) {
                      return 'Enter a valid price';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Number of Rooms',
                  controller: numRoomsController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Number of rooms is required';
                    } else if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Number of Bathrooms',
                  controller: numBathroomsController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Number of bathrooms is required';
                    } else if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Number of Occupants',
                  controller: numOccupantsController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Number of occupants is required';
                    } else if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: kPrimaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonFormField<String>(
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 40,
                      elevation: 16,
                      hint: Text('Select Gender'),
                      value: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a gender';
                        } else {
                          return null;
                        }
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'female',
                          child: Text(
                            'Female',
                            style: TextStyle(color: const Color.fromARGB(255, 98, 97, 97)),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'male',
                          child: Text(
                            'Male',
                            style: TextStyle(color: const Color.fromARGB(255, 98, 97, 97)),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'male and female',
                          child: Text(
                            'Male and female',
                            style: TextStyle(color: const Color.fromARGB(255, 98, 97, 97)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MaterialButton(
                    onPressed: _pickImages,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_outlined),
                        SizedBox(width: 2),
                        Text('Upload Image'),
                      ],
                    ),
                  ),
                ),
                if (imageUrls.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            File(imageUrls[index]),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 30),

              Expanded(
                      child: TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(labelText: 'Location'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _selectLocation,
                      child: Text('Pick Location'),
                    ),
                  
                



                Padding(
                  padding: const EdgeInsets.only(right: 60.0, left: 60),
                  child: ElevatedButton(
                    onPressed: _validateAndAddHouse,
                    child: Center(child: Text('Add House')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      for (var image in images) {
        setState(() {
          imageUrls.add(image.path);
        });
        print('Added image: ${image.path}');
      }
    }
  }

  void _validateAndAddHouse() {
    if (_formKey.currentState!.validate()) {
      _addHouse();
    }
  }

  void _addHouse() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      List<String> uploadedImageUrls = [];
      for (var imagePath in imageUrls) {
        File imageFile = File(imagePath);
        if (imageFile.existsSync()) {
          try {
            String uploadedImageUrl = await firestoreService.uploadImage(imageFile);
            uploadedImageUrls.add(uploadedImageUrl);
          } catch (error) {
            print('Error uploading image: $error');
          }
        } else {
          print('File does not exist: $imagePath');
        }
      }

      final houseData = {
        'userId': user.uid,
        'houseName': houseNameController.text,
        'price': double.parse(priceController.text),
        'numRooms': int.parse(numRoomsController.text),
        'numBathrooms': int.parse(numBathroomsController.text),
        'gender': _selectedGender,
        'numOccupants': int.parse(numOccupantsController.text),
        'email': user.email,
        'imageUrls': uploadedImageUrls,

        'location': locationController.text,
           
            'latitude': latitude,
            'longitude': longitude,
      };

      await firestoreService.addHouse(user.uid, houseData);
      Navigator.pop(context);
    }
  }


  void _selectLocation() async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarkerMapPage(
          onLocationSelected: (latLng) {
            setState(() {
              latitude = latLng.latitude;
              longitude = latLng.longitude;
              locationController.text = 'Selected Location';
            });
          },
        ),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        locationController.text = 'Location Selected';
      });
    }
  }

  @override
  void dispose() {
    houseNameController.dispose();
    priceController.dispose();
    numRoomsController.dispose();
    numBathroomsController.dispose();
    numOccupantsController.dispose();
    super.dispose();
  }
}

class FirestoreService {
  final storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadImage(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference storageReference = storage.ref().child('images/$fileName');

      UploadTask uploadTask = storageReference.putFile(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw error;
    }
  }

  Future<void> addHouse(String userId, Map<String, dynamic> houseData) async {
    try {
      CollectionReference housesCollection =
          firestore.collection('users').doc(userId).collection('houses');

      await housesCollection.add(houseData);

      print('House added successfully.');
    } catch (error) {
      print('Error adding house: $error');
      throw error;
    }
  }
}


*/
/*work

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/widgets/customTextField.dart';
import 'package:flutter_application_1/constant.dart';

import '../../map/markepmappage.dart';
import 'package:image_picker/image_picker.dart';

class AddHousePage extends StatefulWidget {
  @override
  _AddHousePageState createState() => _AddHousePageState();
}

class _AddHousePageState extends State<AddHousePage> {
  final TextEditingController houseNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController numRoomsController = TextEditingController();
  final TextEditingController numBathroomsController = TextEditingController();
  final TextEditingController numOccupantsController = TextEditingController();
  final locationController = TextEditingController();
  double? latitude;
  double? longitude;
  final FirestoreService firestoreService = FirestoreService();

  List<String> imageUrls = [];
  String? _selectedGender;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Add House',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'House Name',
                  controller: houseNameController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'House name is required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Price',
                  controller: priceController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Price is required';
                    } else if (double.tryParse(value!) == null) {
                      return 'Enter a valid price';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Number of Rooms',
                  controller: numRoomsController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Number of rooms is required';
                    } else if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Number of Bathrooms',
                  controller: numBathroomsController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Number of bathrooms is required';
                    } else if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Number of Occupants',
                  controller: numOccupantsController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Number of occupants is required';
                    } else if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: kPrimaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonFormField<String>(
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 40,
                      elevation: 16,
                      hint: Text('Select Gender'),
                      value: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a gender';
                        } else {
                          return null;
                        }
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'female',
                          child: Text(
                            'Female',
                            style: TextStyle(color: const Color.fromARGB(255, 98, 97, 97)),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'male',
                          child: Text(
                            'Male',
                            style: TextStyle(color: const Color.fromARGB(255, 98, 97, 97)),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'male and female',
                          child: Text(
                            'Male and female',
                            style: TextStyle(color: const Color.fromARGB(255, 98, 97, 97)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MaterialButton(
                    onPressed: _pickImages,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_outlined),
                        SizedBox(width: 2),
                        Text('Upload Image'),
                      ],
                    ),
                  ),
                ),
                if (imageUrls.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            File(imageUrls[index]),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(labelText: 'Location'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _selectLocation,
                      child: Text('Pick Location'),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(right: 60.0, left: 60),
                  child: ElevatedButton(
                    onPressed: _validateAndAddHouse,
                    child: Center(child: Text('Add House')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      for (var image in images) {
        setState(() {
          imageUrls.add(image.path);
        });
        print('Added image: ${image.path}');
      }
    }
  }

  void _validateAndAddHouse() {
    if (_formKey.currentState!.validate()) {
      _addHouse();
    }
  }

  void _addHouse() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      List<String> uploadedImageUrls = [];
      for (var imagePath in imageUrls) {
        File imageFile = File(imagePath);
        if (imageFile.existsSync()) {
          try {
            String uploadedImageUrl = await firestoreService.uploadImage(imageFile);
            uploadedImageUrls.add(uploadedImageUrl);
          } catch (error) {
            print('Error uploading image: $error');
          }
        } else {
          print('File does not exist: $imagePath');
        }
      }

      final houseData = {
        'userId': user.uid,
        'houseName': houseNameController.text,
        'price': double.parse(priceController.text),
        'numRooms': int.parse(numRoomsController.text),
        'numBathrooms': int.parse(numBathroomsController.text),
        'gender': _selectedGender,
        'numOccupants': int.parse(numOccupantsController.text),
        'email': user.email,
        'imageUrls': uploadedImageUrls,
        'location': locationController.text,
        'latitude': latitude,
        'longitude': longitude,
      };

      await firestoreService.addHouse(user.uid, houseData);
      Navigator.pop(context);
    }
  }

  void _selectLocation() async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarkerMapPage(
          onLocationSelected: (latLng) {
            setState(() {
              latitude = latLng.latitude;
              longitude = latLng.longitude;
              locationController.text = 'Selected Location';
            });
          },
        ),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        locationController.text = 'Location Selected';
      });
    }
  }

  @override
  void dispose() {
    houseNameController.dispose();
    priceController.dispose();
    numRoomsController.dispose();
    numBathroomsController.dispose();
    numOccupantsController.dispose();
    super.dispose();
  }
}

class FirestoreService {
  final storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadImage(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference storageReference = storage.ref().child('images/$fileName');

      UploadTask uploadTask = storageReference.putFile(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw error;
    }
  }

  Future<void> addHouse(String userId, Map<String, dynamic> houseData) async {
    try {
      CollectionReference housesCollection =
          firestore.collection('users').doc(userId).collection('houses');

      await housesCollection.add(houseData);

      print('House added successfully.');
    } catch (error) {
      print('Error adding house: $error');
      throw error;
    }
  }
}



*/





/*


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/widgets/customTextField.dart';
import 'package:flutter_application_1/constant.dart';

import '../../map/markepmappage.dart';
import 'package:image_picker/image_picker.dart';

class AddHousePage extends StatefulWidget {
  @override
  _AddHousePageState createState() => _AddHousePageState();
}

class _AddHousePageState extends State<AddHousePage> {
  final TextEditingController houseNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController numRoomsController = TextEditingController();
  final TextEditingController numBathroomsController = TextEditingController();
  final TextEditingController numOccupantsController = TextEditingController();
  final locationController = TextEditingController();
  Map<String, dynamic>? locationDetails;
  final FirestoreService firestoreService = FirestoreService();

  List<String> imageUrls = [];
  String? _selectedGender;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Add House',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'House Name',
                  controller: houseNameController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'House name is required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Price',
                  controller: priceController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Price is required';
                    } else if (double.tryParse(value!) == null) {
                      return 'Enter a valid price';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Number of Rooms',
                  controller: numRoomsController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Number of rooms is required';
                    } else if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Number of Bathrooms',
                  controller: numBathroomsController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Number of bathrooms is required';
                    } else if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Number of Occupants',
                  controller: numOccupantsController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Number of occupants is required';
                    } else if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.home),
                            SizedBox(width: 12),
                            Text(
                              'Allowed Gender',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          title: const Text('Male'),
                          leading: Radio<String>(
                            value: 'Male',
                            groupValue: _selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Female'),
                          leading: Radio<String>(
                            value: 'Female',
                            groupValue: _selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Both'),
                          leading: Radio<String>(
                            value: 'Both',
                            groupValue: _selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Location',
                  controller: locationController,
                  readOnly: true,
                  onTap: selectLocation,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Location is required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _uploadImages();
                      },
                      child: Text("Select Images"),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        imageUrls.isNotEmpty
                            ? "Images selected: ${imageUrls.length}"
                            : "No images selected",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveHouse,
                    child: Text('Add House'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectLocation() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarkerMapPage(
          onLocationSelected: (selectedLocation) {
            setState(() {
              locationDetails = selectedLocation;
              locationController.text =
                  '${selectedLocation['name']}, ${selectedLocation['street']}, ${selectedLocation['locality']}, ${selectedLocation['administrativeArea']}, ${selectedLocation['country']}, ${selectedLocation['postalCode']}';
            });
          },
        ),
      ),
    );
  }

  Future<void> _uploadImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      for (var file in pickedFiles) {
        String fileName = file.name;
        File imageFile = File(file.path);

        try {
          final ref = FirebaseStorage.instance.ref().child('house_images/$fileName');
          await ref.putFile(imageFile);
          String imageUrl = await ref.getDownloadURL();
          setState(() {
            imageUrls.add(imageUrl);
          });
        } catch (e) {
          print('Failed to upload image: $e');
        }
      }
    }
  }

  void _saveHouse() async {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      final houseData = {
        'name': houseNameController.text,
        'price': double.parse(priceController.text),
        'numRooms': int.parse(numRoomsController.text),
        'numBathrooms': int.parse(numBathroomsController.text),
        'numOccupants': int.parse(numOccupantsController.text),
        'allowedGender': _selectedGender,
        'location': locationDetails,
        'images': imageUrls,
        'userId': user?.uid,
        'timestamp': Timestamp.now(),
      };

      try {
        await firestoreService.addHouse(houseData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('House added successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add house')),
        );
        print('Failed to add house: $e');
      }
    }
  }
}

class FirestoreService {
  final CollectionReference houses =
      FirebaseFirestore.instance.collection('houses');

  Future<void> addHouse(Map<String, dynamic> houseData) async {
    await houses.add(houseData);
  }
}*/







import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Housing/pages/widgets/customTextField.dart';
import 'package:flutter_application_1/constant.dart';

import '../../map/markepmappage.dart';
import 'package:image_picker/image_picker.dart';

class AddHousePage extends StatefulWidget {
  @override
  _AddHousePageState createState() => _AddHousePageState();
}

class _AddHousePageState extends State<AddHousePage> {
  final TextEditingController houseNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController numRoomsController = TextEditingController();
  final TextEditingController numBathroomsController = TextEditingController();
  final TextEditingController numOccupantsController = TextEditingController();
  final locationController = TextEditingController();
  double? latitude;
  double? longitude;
  final FirestoreService firestoreService = FirestoreService();

  List<String> imageUrls = [];
  String? _selectedGender;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Add House',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'House Name',
                  controller: houseNameController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'House name is required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Price',
                  controller: priceController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Price is required';
                    } else if (double.tryParse(value!) == null) {
                      return 'Enter a valid price';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Number of Rooms',
                  controller: numRoomsController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Number of rooms is required';
                    } else if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Number of Bathrooms',
                  controller: numBathroomsController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Number of bathrooms is required';
                    } else if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Number of Occupants',
                  controller: numOccupantsController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Number of occupants is required';
                    } else if (int.tryParse(value!) == null) {
                      return 'Enter a valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: kPrimaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonFormField<String>(
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 40,
                      elevation: 16,
                      hint: Text('Select Gender'),
                      value: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a gender';
                        } else {
                          return null;
                        }
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'female',
                          child: Text(
                            'Female',
                            style: TextStyle(color: const Color.fromARGB(255, 98, 97, 97)),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'male',
                          child: Text(
                            'Male',
                            style: TextStyle(color: const Color.fromARGB(255, 98, 97, 97)),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'male and female',
                          child: Text(
                            'Male and female',
                            style: TextStyle(color: const Color.fromARGB(255, 98, 97, 97)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MaterialButton(
                    onPressed: _pickImages,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_outlined),
                        SizedBox(width: 2),
                        Text('Upload Image'),
                      ],
                    ),
                  ),
                ),
                if (imageUrls.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            File(imageUrls[index]),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(labelText: 'Location'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _selectLocation,
                      child: Text('Pick Location'),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(right: 60.0, left: 60),
                  child: ElevatedButton(
                    onPressed: _validateAndAddHouse,
                    child: Center(child: Text('Add House')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      for (var image in images) {
        setState(() {
          imageUrls.add(image.path);
        });
        print('Added image: ${image.path}');
      }
    }
  }

  void _validateAndAddHouse() {
    if (_formKey.currentState!.validate()) {
      _addHouse();
    }
  }

  void _addHouse() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      List<String> uploadedImageUrls = [];
      for (var imagePath in imageUrls) {
        File imageFile = File(imagePath);
        if (imageFile.existsSync()) {
          try {
            String uploadedImageUrl = await firestoreService.uploadImage(imageFile);
            uploadedImageUrls.add(uploadedImageUrl);
          } catch (error) {
            print('Error uploading image: $error');
          }
        } else {
          print('File does not exist: $imagePath');
        }
      }

      final houseData = {
        'userId': user.uid,
        'houseName': houseNameController.text,
        'price': double.parse(priceController.text),
        'numRooms': int.parse(numRoomsController.text),
        'numBathrooms': int.parse(numBathroomsController.text),
        'gender': _selectedGender,
        'numOccupants': int.parse(numOccupantsController.text),
        'email': user.email,
        'imageUrls': uploadedImageUrls,
        'location': locationController.text,
        'latitude': latitude,
        'longitude': longitude,
      };

      await firestoreService.addHouse(user.uid, houseData);
      Navigator.pop(context);
    }
  }

  void _selectLocation() async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarkerMapPage(
          onLocationSelected: (latLng) {
            setState(() {
              latitude = latLng.latitude;
              longitude = latLng.longitude;
              locationController.text = 'Selected Location';
            });
          },
        ),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        locationController.text = 'Location Selected';
      });
    }
  }

  @override
  void dispose() {
    houseNameController.dispose();
    priceController.dispose();
    numRoomsController.dispose();
    numBathroomsController.dispose();
    numOccupantsController.dispose();
    super.dispose();
  }
}

class FirestoreService {
  final storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadImage(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference storageReference = storage.ref().child('images/$fileName');

      UploadTask uploadTask = storageReference.putFile(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw error;
    }
  }

  Future<void> addHouse(String userId, Map<String, dynamic> houseData) async {
    try {
      CollectionReference housesCollection =
          firestore.collection('users').doc(userId).collection('houses');

      await housesCollection.add(houseData);

      print('House added successfully.');
    } catch (error) {
      print('Error adding house: $error');
      throw error;
    }
  }
}



