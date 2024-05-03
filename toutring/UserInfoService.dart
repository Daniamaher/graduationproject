import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<Object?> getUserInfo(String studentNumber) async {
    try {
      final DocumentSnapshot document = await _users.doc(studentNumber).get();
      if (document.exists) {
        return document.data();
      } else {
        print('No user found with student number: $studentNumber');
        return null;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
