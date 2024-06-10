import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
/*
class EditBookPage extends StatefulWidget {
  final String? collegeId;
  final String? departmentId;
  final String? bookId;
  final Map<String, dynamic> initialData;

  EditBookPage({
    Key? key,
    this.collegeId,
    this.departmentId,
    this.bookId,
    required this.initialData,
  }) : super(key: key);

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController additionalDetailsController = TextEditingController();
  List<String> imageUrls = [];
  final FirestoreService firestoreService = FirestoreService();
  String bookStatus = 'New';  // Default status

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the initial data
    bookNameController.text = widget.initialData['bookName'];
    bookPriceController.text = widget.initialData['bookPrice'];
    additionalDetailsController.text = widget.initialData['additionalDetails'];
    imageUrls = List<String>.from(widget.initialData['imageUrls']);
    bookStatus = widget.initialData['bookStatus'];
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      setState(() {
        imageUrls = images.map((image) => image.path).toList();
      });
      print('Added images: $imageUrls');
    }
  }

  Future<List<String>> _uploadImages() async {
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
    return uploadedImageUrls;
  }

  Future<void> updateBookInFirestore(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      List<String> uploadedImageUrls = await _uploadImages();

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection('Colleges')
            .doc(widget.collegeId)
            .collection('Departments')
            .doc(widget.departmentId)
            .collection('Books')
            .doc(widget.bookId)
            .update({
          'bookName': bookNameController.text,
          'bookPrice': bookPriceController.text,
          'imageUrls': uploadedImageUrls,
          'bookStatus': bookStatus,
          'additionalDetails': additionalDetailsController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Book updated successfully!'),
        ));

        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Book Name'),
                  controller: bookNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Book Price'),
                  controller: bookPriceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Book Status'),
                    Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('New'),
                          value: 'New',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Good'),
                          value: 'Good',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Half-half'),
                          value: 'Half-half',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Bad'),
                          value: 'Bad',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Additional Details (optional)',
                    hintText: 'Include any extra details or mention the book name that you want to exchange it with your book',
                  ),
                  controller: additionalDetailsController,
                  maxLines: 3,
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
                        Text('Upload Images'),
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
                ElevatedButton(
                  onPressed: () {
                    updateBookInFirestore(context);
                  },
                  child: Text('Update Book'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirestoreService {
  Future<String> uploadImage(File imageFile) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('booksimages/$imageName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw error;
    }
  }
}
*/



/*

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditBookPage extends StatefulWidget {
  final String? collegeId;
  final String? departmentId;
  final String? bookId;

  EditBookPage({
    Key? key,
    this.collegeId,
    this.departmentId,
    this.bookId,
  }) : super(key: key);

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController additionalDetailsController = TextEditingController();
  List<String> imageUrls = [];
  final FirestoreService firestoreService = FirestoreService();
  String bookStatus = 'New';  // Default status

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      setState(() {
        imageUrls = images.map((image) => image.path).toList();
      });
      print('Added images: $imageUrls');
    }
  }

  Future<List<String>> _uploadImages() async {
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
    return uploadedImageUrls;
  }

  Future<void> updateBookInFirestore(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      List<String> uploadedImageUrls = await _uploadImages();

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection('Colleges')
            .doc(widget.collegeId)
            .collection('Departments')
            .doc(widget.departmentId)
            .collection('Books')
            .doc(widget.bookId)
            .update({
          'bookName': bookNameController.text,
          'bookPrice': bookPriceController.text,
          'imageUrls': uploadedImageUrls,
          'bookStatus': bookStatus,
          'additionalDetails': additionalDetailsController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Book updated successfully!'),
        ));

        Navigator.pop(context);
      }
    }
  }

  Future<Map<String, dynamic>> getBookData(String collegeId, String departmentId, String bookId) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Colleges')
        .doc(collegeId)
        .collection('Departments')
        .doc(departmentId)
        .collection('Books')
        .doc(bookId)
        .get();
    return documentSnapshot.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getBookData(widget.collegeId!, widget.departmentId!, widget.bookId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching book data'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            bookNameController.text = data['bookName'];
            bookPriceController.text = data['bookPrice'];
            additionalDetailsController.text = data['additionalDetails'];
            imageUrls = List<String>.from(data['imageUrls']);
            bookStatus = data['bookStatus'];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Book Name'),
                        controller: bookNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter book name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Book Price'),
                        controller: bookPriceController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter book price';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Book Status'),
                          Column(
                            children: [
                              RadioListTile<String>(
                                title: const Text('New'),
                                value: 'New',
                                groupValue: bookStatus,
                                onChanged: (value) {
                                  setState(() {
                                    bookStatus = value!;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Good'),
                                value: 'Good',
                                groupValue: bookStatus,
                                onChanged: (value) {
                                  setState(() {
                                    bookStatus = value!;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Half-half'),
                                value: 'Half-half',
                                groupValue: bookStatus,
                                onChanged: (value) {
                                  setState(() {
                                    bookStatus = value!;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Bad'),
                                value: 'Bad',
                                groupValue: bookStatus,
                                onChanged: (value) {
                                  setState(() {
                                    bookStatus = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Additional Details (optional)',
                          hintText: 'Include any extra details or mention the book name that you want to exchange it with your book',
                        ),
                        controller: additionalDetailsController,
                        maxLines: 3,
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
                              Text('Upload Images'),
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
                      ElevatedButton(
                        onPressed: () {
                          updateBookInFirestore(context);
                        },
                        child: Text('Update Book'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}

class FirestoreService {
  Future<String> uploadImage(File imageFile) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('booksimages/$imageName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw error;
    }
  }
}
*/








/*notedit





import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditBookPage extends StatefulWidget {
  final Map<String, dynamic> bookData;

  EditBookPage({Key? key, required this.bookData}) : super(key: key);

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController additionalDetailsController = TextEditingController();
  List<String> imageUrls = [];
  final FirestoreService firestoreService = FirestoreService();
  String bookStatus = 'New'; // Default status

  @override
  void initState() {
    super.initState();
    // Populate form fields with existing book data
    bookNameController.text = widget.bookData['bookName'];
    bookPriceController.text = widget.bookData['bookPrice'];
    additionalDetailsController.text = widget.bookData['additionalDetails'] ?? '';
    imageUrls = List<String>.from(widget.bookData['imageUrls']);
    bookStatus = widget.bookData['bookStatus'] ?? 'New';
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      setState(() {
        imageUrls = images.map((image) => image.path).toList();
      });
      print('Added images: $imageUrls');
    }
  }

  Future<List<String>> _uploadImages() async {
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
    return uploadedImageUrls;
  }

  Future<void> saveBookToFirestore(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      List<String> uploadedImageUrls = await _uploadImages();

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Update existing book
        await FirebaseFirestore.instance
            .collection('Colleges')
            .doc(widget.bookData['collegeId'])
            .collection('Departments')
            .doc(widget.bookData['departmentId'])
            .collection('Books')
            .doc(widget.bookData['id'])
            .update({
          'bookName': bookNameController.text,
          'bookPrice': bookPriceController.text,
          'imageUrls': uploadedImageUrls,
          'bookStatus': bookStatus,
          'additionalDetails': additionalDetailsController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Book updated successfully!'),
        ));

        Navigator.pop(context); // Go back to the previous screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Book Name'),
                  controller: bookNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Book Price'),
                  controller: bookPriceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Book Status'),
                    Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('New'),
                          value: 'New',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Good'),
                          value: 'Good',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Half-half'),
                          value: 'Half-half',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Bad'),
                          value: 'Bad',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Additional Details (optional)',
                    hintText: 'Include any extra details or mention the book name that you want to exchange it with your book',
                  ),
                  controller: additionalDetailsController,
                  maxLines: 3,
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
                        Text('Upload Images'),
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
                ElevatedButton(
                  onPressed: () {
                    saveBookToFirestore(context);
                  },
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirestoreService {
  Future<String> uploadImage(File imageFile) async {
    try {
      // Generate a unique ID for the image
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();

      // Reference to the Firebase Storage bucket
      Reference storageReference =
          FirebaseStorage.instance.ref().child('booksimages/$imageName');

      // Upload the image file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(imageFile);

      // Get the download URL of the uploaded image
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Return the URL of the uploaded image
      return imageUrl;
    } catch (error) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $error');
      throw error;
    }
  }
}

*/













/*

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditBookPage extends StatefulWidget {
  final String collegeId;
  final String departmentId;
  final String bookId;
  final Map<String, dynamic> bookData;

  EditBookPage({
    required this.collegeId,
    required this.departmentId,
    required this.bookId,
    required this.bookData,
  });

  @override
  _EditBookPageState createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController additionalDetailsController = TextEditingController();
  List<String> imageUrls = [];
  String bookStatus = 'New'; // Default status

  @override
  void initState() {
    super.initState();
    bookNameController.text = widget.bookData['bookName'];
    bookPriceController.text = widget.bookData['bookPrice'];
    additionalDetailsController.text = widget.bookData['additionalDetails'];
    bookStatus = widget.bookData['bookStatus'];
    imageUrls = List<String>.from(widget.bookData['imageUrls'] ?? []);
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      try {
        for (var image in images) {
          File imageFile = File(image.path);
          String uploadedImageUrl = await _uploadImage(imageFile);
          setState(() {
            imageUrls.add(uploadedImageUrl);
          });
        }
      } catch (error) {
        print('Error uploading image: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading image. Please try again.'),
          ),
        );
      }
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance.ref().child('booksimages/$fileName');
      await storageReference.putFile(imageFile);
      String downloadUrl = await storageReference.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw error;
    }
  }

  void _deleteImage(int index) {
    setState(() {
      imageUrls.removeAt(index);
    });
  }

  void _saveChanges() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final updatedBookData = {
          'bookName': bookNameController.text,
          'bookPrice': bookPriceController.text,
          'additionalDetails': additionalDetailsController.text,
          'bookStatus': bookStatus,
          'imageUrls': imageUrls,
          'email': user.email,
          'userId': user.uid,
        };

        await FirebaseFirestore.instance
            .collection('Colleges')
            .doc(widget.collegeId)
            .collection('Departments')
            .doc(widget.departmentId)
            .collection('Books')
            .doc(widget.bookId)
            .update(updatedBookData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Book updated successfully!'),
          ),
        );

        Navigator.pop(context);
      } catch (error) {
        print('Error updating book: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating book. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Book Name'),
                  controller: bookNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Book Price'),
                  controller: bookPriceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Book Status'),
                    Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('New'),
                          value: 'New',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Good'),
                          value: 'Good',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Half-half'),
                          value: 'Half-half',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Bad'),
                          value: 'Bad',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Additional Details (optional)',
                    hintText: 'Include any extra details or mention the book name that you want to exchange it with your book',
                  ),
                  controller: additionalDetailsController,
                  maxLines: 3,
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
                        Text('Upload Images'),
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
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                imageUrls[index],
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteImage(index);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _saveChanges,
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bookNameController.dispose();
    bookPriceController.dispose();
    additionalDetailsController.dispose();
    super.dispose();
  }
}
*/















/*

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditBookPage extends StatefulWidget {
  final Map<String, dynamic> bookData;

  EditBookPage({Key? key, required this.bookData}) : super(key: key);

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController additionalDetailsController = TextEditingController();
  List<String> imageUrls = [];
  List<File> newImages = [];
  final FirestoreService firestoreService = FirestoreService();
  String bookStatus = 'New'; // Default status

  @override
  void initState() {
    super.initState();
    // Populate form fields with existing book data
    bookNameController.text = widget.bookData['bookName'];
    bookPriceController.text = widget.bookData['bookPrice'];
    additionalDetailsController.text = widget.bookData['additionalDetails'] ?? '';
    imageUrls = List<String>.from(widget.bookData['imageUrls']);
    bookStatus = widget.bookData['bookStatus'] ?? 'New';
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      setState(() {
        newImages = images.map((image) => File(image.path)).toList();
      });
      print('Added images: ${newImages.map((file) => file.path).toList()}');
    }
  }

  Future<List<String>> _uploadImages() async {
    List<String> uploadedImageUrls = [];
    for (var imageFile in newImages) {
      if (imageFile.existsSync()) {
        try {
          String uploadedImageUrl = await firestoreService.uploadImage(imageFile);
          uploadedImageUrls.add(uploadedImageUrl);
        } catch (error) {
          print('Error uploading image: $error');
        }
      } else {
        print('File does not exist: ${imageFile.path}');
      }
    }
    return uploadedImageUrls;
  }

  Future<void> saveBookToFirestore(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      List<String> uploadedImageUrls = await _uploadImages();

      // Combine existing and new image URLs
      List<String> finalImageUrls = List.from(imageUrls)..addAll(uploadedImageUrls);

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Update existing book
        await FirebaseFirestore.instance
            .collection('Colleges')
            .doc(widget.bookData['collegeId'])
            .collection('Departments')
            .doc(widget.bookData['departmentId'])
            .collection('Books')
            .doc(widget.bookData['id'])
            .update({
          'bookName': bookNameController.text,
          'bookPrice': bookPriceController.text,
          'imageUrls': finalImageUrls,
          'bookStatus': bookStatus,
          'additionalDetails': additionalDetailsController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Book updated successfully!'),
        ));

        Navigator.pop(context); // Go back to the previous screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Book Name'),
                  controller: bookNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Book Price'),
                  controller: bookPriceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Book Status'),
                    Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('New'),
                          value: 'New',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Good'),
                          value: 'Good',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Half-half'),
                          value: 'Half-half',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Bad'),
                          value: 'Bad',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Additional Details (optional)',
                    hintText: 'Include any extra details or mention the book name that you want to exchange it with your book',
                  ),
                  controller: additionalDetailsController,
                  maxLines: 3,
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
                        Text('Upload Images'),
                      ],
                    ),
                  ),
                ),
                if (imageUrls.isNotEmpty || newImages.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageUrls.length + newImages.length,
                      itemBuilder: (context, index) {
                        if (index < imageUrls.length) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              imageUrls[index],
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              newImages[index - imageUrls.length],
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    saveBookToFirestore(context);
                  },
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirestoreService {
  Future<String> uploadImage(File imageFile) async {
    try {
      // Generate a unique ID for the image
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();

      // Reference to the Firebase Storage bucket
      Reference storageReference =
          FirebaseStorage.instance.ref().child('booksimages/$imageName');

      // Upload the image file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(imageFile);

      // Get the download URL of the uploaded image
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Return the URL of the uploaded image
      return imageUrl;
    } catch (error) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $error');
      throw error;
    }
  }
}
*/




/*


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditBookPage extends StatefulWidget {
  final Map<String, dynamic> bookData;

  EditBookPage({Key? key, required this.bookData}) : super(key: key) {
    // Debugging the constructor parameters
    print('Constructor - bookData: $bookData');
  }

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController additionalDetailsController = TextEditingController();
  List<String> imageUrls = [];
  List<File> newImages = [];
  final FirestoreService firestoreService = FirestoreService();
  String bookStatus = 'New'; // Default status

  @override
  void initState() {
    super.initState();
    // Populate form fields with existing book data
    print('initState - bookData: ${widget.bookData}');
    bookNameController.text = widget.bookData['bookName'];
    bookPriceController.text = widget.bookData['bookPrice'];
    additionalDetailsController.text = widget.bookData['additionalDetails'] ?? '';
    imageUrls = List<String>.from(widget.bookData['imageUrls']);
    bookStatus = widget.bookData['bookStatus'] ?? 'New';
    print('initState - bookNameController: ${bookNameController.text}');
    print('initState - bookPriceController: ${bookPriceController.text}');
    print('initState - additionalDetailsController: ${additionalDetailsController.text}');
    print('initState - imageUrls: $imageUrls');
    print('initState - bookStatus: $bookStatus');
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      setState(() {
        newImages = images.map((image) => File(image.path)).toList();
      });
      print('Added images: ${newImages.map((file) => file.path).toList()}');
    }
  }

  Future<List<String>> _uploadImages() async {
    List<String> uploadedImageUrls = [];
    for (var imageFile in newImages) {
      if (imageFile.existsSync()) {
        try {
          String uploadedImageUrl = await firestoreService.uploadImage(imageFile);
          uploadedImageUrls.add(uploadedImageUrl);
          print('Uploaded image URL: $uploadedImageUrl');
        } catch (error) {
          print('Error uploading image: $error');
        }
      } else {
        print('File does not exist: ${imageFile.path}');
      }
    }
    return uploadedImageUrls;
  }
/*
  Future<void> saveBookToFirestore(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      List<String> uploadedImageUrls = await _uploadImages();

      // Combine existing and new image URLs
      List<String> finalImageUrls = List.from(imageUrls)..addAll(uploadedImageUrls);

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Debug information before updating Firestore
        print('saveBookTjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjoFirestore - bookName: ${bookNameController.text}');
        print('saveBookToFirestore - bookPrice: ${bookPriceController.text}');
        print('saveBookToFirestore - finalImageUrls: $finalImageUrls');
        print('saveBookToFirestore - bookStatus: $bookStatus');
        print('saveBookToFirestore - additionalDetails: ${additionalDetailsController.text}');

        // Update existing book
        await FirebaseFirestore.instance
            .collection('Colleges')
            .doc(widget.bookData['collegeId'])
            .collection('Departments')
            .doc(widget.bookData['departmentId'])
            .collection('Books')
            .doc(widget.bookData['id'])
            .update({
          'bookName': bookNameController.text,
          'bookPrice': bookPriceController.text,
          'imageUrls': finalImageUrls,
          'bookStatus': bookStatus,
          'additionalDetails': additionalDetailsController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Book updated successfully!'),
        ));

        Navigator.pop(context); // Go back to the previous screen
      }
    }
  }*/


  Future<void> saveBookToFirestore(BuildContext context) async {
  if (formKey.currentState!.validate()) {
    formKey.currentState!.save();

    List<String> uploadedImageUrls = await _uploadImages();

    // Combine existing and new image URLs
    List<String> finalImageUrls = List.from(imageUrls)..addAll(uploadedImageUrls);

    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Debug information before updating Firestore
      String collegeId = widget.bookData['collegeId'];
      String departmentId = widget.bookData['departmentId'];
      String bookId = widget.bookData['id'];

      print('saveBookToFirestore - bookName: ${bookNameController.text}');
      print('saveBookToFirestore - bookPrice: ${bookPriceController.text}');
      print('saveBookToFirestore - finalImageUrls: $finalImageUrls');
      print('saveBookToFirestore - bookStatus: $bookStatus');
      print('saveBookToFirestore - additionalDetails: ${additionalDetailsController.text}');
      print('saveBookToFirestore - collegeId: $collegeId');
      print('saveBookToFirestore - departmentId: $departmentId');
      print('saveBookToFirestore - bookId: $bookId');

      // Update existing book
      await FirebaseFirestore.instance
          .collection('Colleges')
          .doc(collegeId)
          .collection('Departments')
          .doc(departmentId)
          .collection('Books')
          .doc(bookId)
          .update({
        'bookName': bookNameController.text,
        'bookPrice': bookPriceController.text,
        'imageUrls': finalImageUrls,
        'bookStatus': bookStatus,
        'additionalDetails': additionalDetailsController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book updated successfully!'),
      ));

      Navigator.pop(context); // Go back to the previous screen
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Book Name'),
                  controller: bookNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Book Price'),
                  controller: bookPriceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Book Status'),
                    Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('New'),
                          value: 'New',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Good'),
                          value: 'Good',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Half-half'),
                          value: 'Half-half',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Bad'),
                          value: 'Bad',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Additional Details (optional)',
                    hintText: 'Include any extra details or mention the book name that you want to exchange it with your book',
                  ),
                  controller: additionalDetailsController,
                  maxLines: 3,
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
                        Text('Upload Images'),
                      ],
                    ),
                  ),
                ),
                if (imageUrls.isNotEmpty || newImages.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageUrls.length + newImages.length,
                      itemBuilder: (context, index) {
                        if (index < imageUrls.length) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              imageUrls[index],
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              newImages[index - imageUrls.length],
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    saveBookToFirestore(context);
                  },
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirestoreService {
  Future<String> uploadImage(File imageFile) async {
    try {
      // Generate a unique ID for the image
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();

      // Reference to the Firebase Storage bucket
      Reference storageReference =
          FirebaseStorage.instance.ref().child('booksimages/$imageName');

      // Upload the image file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(imageFile);

      // Get the download URL of the uploaded image
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Return the URL of the uploaded image
      return imageUrl;
    } catch (error) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $error');
      throw error;
    }
  }
}

*/




















import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditBookPage extends StatefulWidget {
  final Map<String, dynamic> bookData;

  EditBookPage({Key? key, required this.bookData}) : super(key: key) {
    // Debugging the constructor parameters
    print('Constructor - bookData: $bookData');
  }

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController additionalDetailsController = TextEditingController();
  List<String> imageUrls = [];
  List<File> newImages = [];
  final FirestoreService firestoreService = FirestoreService();
  String bookStatus = 'New'; // Default status

  @override
  void initState() {
    super.initState();
    // Populate form fields with existing book data
    print('initState - bookData: ${widget.bookData}');
    bookNameController.text = widget.bookData['bookName'];
    bookPriceController.text = widget.bookData['bookPrice'];
    additionalDetailsController.text = widget.bookData['additionalDetails'] ?? '';
    imageUrls = List<String>.from(widget.bookData['imageUrls']);
    bookStatus = widget.bookData['bookStatus'] ?? 'New';
    print('initState - bookNameController: ${bookNameController.text}');
    print('initState - bookPriceController: ${bookPriceController.text}');
    print('initState - additionalDetailsController: ${additionalDetailsController.text}');
    print('initState - imageUrls: $imageUrls');
    print('initState - bookStatus: $bookStatus');
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      setState(() {
        newImages = images.map((image) => File(image.path)).toList();
      });
      print('Added images: ${newImages.map((file) => file.path).toList()}');
    }
  }

  Future<List<String>> _uploadImages() async {
    List<String> uploadedImageUrls = [];
    for (var imageFile in newImages) {
      if (imageFile.existsSync()) {
        try {
          String uploadedImageUrl = await firestoreService.uploadImage(imageFile);
          uploadedImageUrls.add(uploadedImageUrl);
          print('Uploaded image URL: $uploadedImageUrl');
        } catch (error) {
          print('Error uploading image: $error');
        }
      } else {
        print('File does not exist: ${imageFile.path}');
      }
    }
    return uploadedImageUrls;
  }

  Future<void> saveBookToFirestore(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      List<String> uploadedImageUrls = await _uploadImages();

      // Combine existing and new image URLs
      List<String> finalImageUrls = List.from(imageUrls)..addAll(uploadedImageUrls);

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Debug information before updating Firestore
        /*
        String collegeId = widget.bookData['collegeId'];
        String departmentId = widget.bookData['departmentId'];
        String bookId = widget.bookData['id'];*/
        String collegeId = widget.bookData['collegeId'] ?? '';
String departmentId = widget.bookData['departmentId'] ?? '';
String bookId = widget.bookData['bookId']?? '';


        print('saveBookToFirestore - bookName: ${bookNameController.text}');
        print('saveBookToFirestore - bookPrice: ${bookPriceController.text}');
        print('saveBookToFirestore - finalImageUrls: $finalImageUrls');
        print('saveBookToFirestore - bookStatus: $bookStatus');
        print('saveBookToFirestore - additionalDetails: ${additionalDetailsController.text}');
        print('saveBookToFirestore - collegeId: $collegeId');
        print('saveBookToFirestore - departmentId: $departmentId');
        print('saveBookToFirestore - bookId: $bookId');

        // Update existing book
        await FirebaseFirestore.instance
            .collection('Colleges')
            .doc(collegeId)
            .collection('Departments')
            .doc(departmentId)
            .collection('Books')
            .doc(bookId)
            .update({
          'bookName': bookNameController.text,
          'bookPrice': bookPriceController.text,
          'imageUrls': finalImageUrls,
          'bookStatus': bookStatus,
          'additionalDetails': additionalDetailsController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Book updated successfully!'),
        ));

        Navigator.pop(context); // Go back to the previous screen
      } else {
        print('saveBookToFirestore - currentUser is null');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Book Name'),
                  controller: bookNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Book Price'),
                  controller: bookPriceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Book Status'),
                    Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('New'),
                          value: 'New',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Good'),
                          value: 'Good',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Half-half'),
                          value: 'Half-half',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Bad'),
                          value: 'Bad',
                          groupValue: bookStatus,
                          onChanged: (value) {
                            setState(() {
                              bookStatus = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Additional Details (optional)',
                    hintText: 'Include any extra details or mention the book name that you want to exchange it with your book',
                  ),
                  controller: additionalDetailsController,
                  maxLines: 3,
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
                        Text('Upload Images'),
                      ],
                    ),
                  ),
                ),
                if (imageUrls.isNotEmpty || newImages.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageUrls.length + newImages.length,
                      itemBuilder: (context, index) {
                        if (index < imageUrls.length) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              imageUrls[index],
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              newImages[index - imageUrls.length],
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    saveBookToFirestore(context);
                  },
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirestoreService {
  Future<String> uploadImage(File imageFile) async {
    try {
      // Generate a unique ID for the image
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();

      // Reference to the Firebase Storage bucket
      Reference storageReference =
          FirebaseStorage.instance.ref().child('booksimages/$imageName');

      // Upload the image file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(imageFile);

      // Get the download URL of the uploaded image
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Return the URL of the uploaded image
      return imageUrl;
    } catch (error) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $error');
      throw error;
    }
  }
}








