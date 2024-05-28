import 'dart:io';
//import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ExchangeBook/exchangebookpage.dart';
import 'package:flutter_application_1/Housing/pages/addhousepage.dart';
import 'package:flutter_application_1/Housing/pages/widgets/customTextField.dart';
import 'package:flutter_application_1/Housing/pages/widgets/custom_button.dart';
import 'package:flutter_application_1/constant.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

/*
class AddBookPage extends StatefulWidget {
  AddBookPage({Key? key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  File? file;
  late String imageUrl;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageGallery =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageGallery != null) {
      file = File(imageGallery.path);
      var imageName = basename(imageGallery.path);
      var refStorage = FirebaseStorage.instance.ref("images").child(imageName);
      await refStorage.putFile(file!);
      imageUrl = await refStorage.getDownloadURL();
      print('Image uploaded successfully. URL: $imageUrl');
      setState(() {});
    }
  }

  String? bookName, bookPrice;

  Future<void> addBookToFirestore(BuildContext context) async {
        FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;


    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await FirebaseFirestore.instance.collection('Students').doc(currentUser?.uid).collection('books').add({
        'bookName': bookNameController.text,
        'bookPrice': bookPriceController.text,
        'imageUrl': imageUrl,
        'email': emailController.text,
        //'uniNumber': currentUser?.uniNumber,
        'userId': currentUser?.uid,
      });
      print('Book added successfully!');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book added successfully!'),
      ));
      bookNameController.clear();
      bookPriceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Add Book',
          style: TextStyle(color: ksecondaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  hint: 'Book Name',
                  onSaved: (value) {
                    bookName = value;
                  },
                  controller: bookNameController,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hint: 'Book Price',
                  onSaved: (value) {
                    bookPrice = value;
                  },
                  controller: bookPriceController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Email',
                  onSaved: (value) {
                    //email= value;
                  },
                  controller: emailController,
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MaterialButton(
                    onPressed: getImage,
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
                SizedBox(height: 20),
                CustomButton(
                  textbutton: 'Add Book',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      addBookToFirestore(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExchangeBookPage()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/









/*

class AddBookPage extends StatefulWidget {
  final String ?collegeId;
  final String ?departmentId;
  AddBookPage({Key? key,  this.collegeId,this.departmentId});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File? file;
  late String imageUrl;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageGallery = await picker.pickImage(source: ImageSource.gallery);
    if (imageGallery != null) {
      file = File(imageGallery.path);
      var imageName = basename(imageGallery.path);
      var refStorage = FirebaseStorage.instance.ref("images").child(imageName);
      await refStorage.putFile(file!);
      imageUrl = await refStorage.getDownloadURL();
      setState(() {});
    }
  }

  Future<void> addBookToFirestore(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await FirebaseFirestore.instance
          .collection('Colleges')
          .doc(widget.collegeId)
          .collection('Departments')
          .doc(widget.departmentId)
          .collection('Books')
          .add({
        'bookName': bookNameController.text,
        'bookPrice': bookPriceController.text,
        'imageUrl': imageUrl,
        'email': emailController.text,
        'userId': currentUser?.uid,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book added successfully!'),
      ));
      bookNameController.clear();
      bookPriceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Add Book', style: TextStyle(color: ksecondaryColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  hint: 'Book Name',
                  controller: bookNameController,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hint: 'Book Price',
                  controller: bookPriceController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Email',
                  controller: emailController,
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MaterialButton(
                    onPressed: getImage,
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
                SizedBox(height: 20),
                CustomButton(
                  textbutton: 'Add Book',
                  onTap: () {
                    addBookToFirestore(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/





/*correct no image slide

class AddBookPage extends StatefulWidget {
  final String? collegeId;
  final String? departmentId;

  AddBookPage({Key? key, this.collegeId, this.departmentId});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  List<String> imageUrls = [];
  final FirestoreService firestoreService = FirestoreService();

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
      return uploadedImageUrls;
    }
    return [];
  }

  Future<void> addBookToFirestore(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      List<String> uploadedImageUrls = await _uploadImages();

      FirebaseAuth auth = FirebaseAuth.instance;
      User? currentUser = auth.currentUser;

      await FirebaseFirestore.instance
          .collection('Colleges')
          .doc(widget.collegeId)
          .collection('Departments')
          .doc(widget.departmentId)
          .collection('Books')
          .add({
        'bookName': bookNameController.text,
        'bookPrice': bookPriceController.text,
        'imageUrls': uploadedImageUrls,
        'email': emailController.text,
        'userId': currentUser?.uid,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book added successfully!'),
      ));

      bookNameController.clear();
      bookPriceController.clear();
      emailController.clear();
      setState(() {
        imageUrls.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Add Book', style: TextStyle(color: ksecondaryColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  hint: 'Book Name',
                  controller: bookNameController,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hint: 'Book Price',
                  controller: bookPriceController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Email',
                  controller: emailController,
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
                SizedBox(height: 20),
                CustomButton(
                  textbutton: 'Add Book',
                  onTap: () {
                    addBookToFirestore(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/












/*correct



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddBookPage extends StatefulWidget {
  final String? collegeId;
  final String? departmentId;

  AddBookPage({Key? key, this.collegeId, this.departmentId});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  List<String> imageUrls = [];
  final FirestoreService firestoreService = FirestoreService();

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
      return uploadedImageUrls;
    }
    return [];
  }

  Future<void> addBookToFirestore(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      List<String> uploadedImageUrls = await _uploadImages();

      FirebaseAuth auth = FirebaseAuth.instance;
      User? currentUser = auth.currentUser;

      await FirebaseFirestore.instance
          .collection('Colleges')
          .doc(widget.collegeId)
          .collection('Departments')
          .doc(widget.departmentId)
          .collection('Books')
          .add({
        'bookName': bookNameController.text,
        'bookPrice': bookPriceController.text,
        'imageUrls': uploadedImageUrls,
        'email': emailController.text,
        'userId': currentUser?.uid,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book added successfully!'),
      ));

      bookNameController.clear();
      bookPriceController.clear();
      emailController.clear();
      setState(() {
        imageUrls.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Add Book', style: TextStyle(color: ksecondaryColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  hint: 'Book Name',
                  controller: bookNameController,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hint: 'Book Price',
                  controller: bookPriceController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Email',
                  controller: emailController,
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
                CustomButton(
                  textbutton: 'Add Book',
                  onTap: () {
                    addBookToFirestore(context);
                  },
                ),
              ],
            ),          ),
        ),
      ),
    );
  }
}

*/











import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddBookPage extends StatefulWidget {
  final String? collegeId;
  final String? departmentId;

  AddBookPage({Key? key, this.collegeId, this.departmentId});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  List<String> imageUrls = [];
  final FirestoreService firestoreService = FirestoreService();

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

  Future<void> addBookToFirestore(BuildContext context) async {
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
            .add({
          'bookName': bookNameController.text,
          'bookPrice': bookPriceController.text,
          'imageUrls': uploadedImageUrls,
          'email': currentUser.email,
          'userId': currentUser.uid,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Book added successfully!'),
        ));

        bookNameController.clear();
        bookPriceController.clear();
        setState(() {
          imageUrls.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
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
                    addBookToFirestore(context);
                  },
                  child: Text('Add Book'),
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

