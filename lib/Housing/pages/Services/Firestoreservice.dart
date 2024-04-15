/*import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');




   Future<String> uploadImage(File file) async {
    try {
      // Generate a unique file name for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      
      // Get a reference to the Firebase Storage location
      Reference storageReference = _storage.ref().child('images/$fileName');
      
      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(file);
      
      // Wait for the upload to complete and get the download URL
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      
      // Return the download URL
      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw error; // Throw the error to handle it in the calling function
    }
  }















  Future<void> addHouse(String userId, Map<String, dynamic> houseData) async {
    await usersCollection.doc(userId).collection('houses').add(houseData);
  }

  Stream<QuerySnapshot> getHouses(String userId) {
    return usersCollection.doc(userId).collection('houses').snapshots();
  }
}
*/

/*
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file) async {
    try {
      // Generate a unique file name for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      
      // Get a reference to the Firebase Storage location
      Reference storageReference = storage.ref().child('images/$fileName');
      
      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(file);
      
      // Wait for the upload to complete and get the download URL
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      
      // Return the download URL
      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw error; // Throw the error to handle it in the calling function
    }
  }

  Future<void> addHouse(String userId, Map<String, dynamic> houseData) async {
    // Your implementation of addHouse method goes here
  }
}
*/

/*
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file) async {
    try {
      // Generate a unique file name for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      
      // Get a reference to the Firebase Storage location
      Reference storageReference = storage.ref().child('images/$fileName');
      
      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(file);
      
      // Wait for the upload to complete and get the download URL
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      
      // Return the download URL
      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw error; // Throw the error to handle it in the calling function
    }
  }

  Future<void> addHouse(String userId, Map<String, dynamic> houseData) async {
    // Your implementation of addHouse method goes here
  }
}
*/