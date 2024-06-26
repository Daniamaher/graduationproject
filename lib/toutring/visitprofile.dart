

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cstum/listProfile.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class VistingProfileScreen extends StatefulWidget {
  final String studentId;

  const VistingProfileScreen({Key? key, required this.studentId})
      : super(key: key);

  @override
  State<VistingProfileScreen> createState() => _VistingProfileScreenState();
}

class _VistingProfileScreenState extends State<VistingProfileScreen> {
  late User _user;
  late String profileImage;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    profileImage = ''; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F3F3),
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white)),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('Students')
            .where('IDNumber', isEqualTo: widget.studentId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('User data not found'));
          }

          var userData =
              snapshot.data!.docs.first.data() as Map<String, dynamic>;

          var profileImageUrl = userData['profileImageUrl'] ?? '';
          if (profileImageUrl.isEmpty) {
            final gender = userData['gender'];
            profileImageUrl = gender == 'male'
                ? 'https://i.pinimg.com/564x/22/ce/12/22ce126b77afdd24a5994ecb51736887.jpg'
                : 'https://i.pinimg.com/736x/8b/1f/9f/8b1f9f145889835124f968a6aa82b79f.jpg';
          }

          profileImage =
              profileImageUrl; 

          return SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100), 
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profileImage),
                  ),
                  Text(
                    '${userData['firstName']} ${userData['lastName']}' ?? 'N/A',
                    style: const TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    userData['major'] ?? 'N/A',
                    style: const TextStyle(
                      fontFamily: "Montserrat",
                      color: Color(0xFF111236),
                      fontSize: 16,
                    ),
                  ),
                  Container(
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
                        const SizedBox(height: 16),
                        listProfile(Icons.person, "Full Name",
                            '${userData['firstName']} ${userData['lastName']}'),
                        listProfile(Icons.female, "Gender",
                            userData['gender'] ?? 'N/A'),
                        listProfile(Icons.school, "Department",
                            userData['Department'] ?? 'N/A'),
                        const SizedBox(
                          height: 14,
                        ),
                        if (userData['IDNumber'] == widget.studentId &&
                            userData['wantsToTeach'] == true)
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Students')
                                .doc(snapshot.data!.docs.first.id)
                                .collection('TeachingSubjects')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Center(child: Text('No subjects found'));
                              }

                              var subjects = <Widget>[
                                Text(
                                  '  I can help you with this material:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ];
                              snapshot.data!.docs.forEach((doc) {
                                var subjectData =
                                    doc.data() as Map<String, dynamic>;
                                var subjectWidget = Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        size: 6,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "  ${subjectData['subject']}",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                subjects.add(subjectWidget);
                              });

                              return SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: subjects,
                                ),
                              );
                            },
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Contact Details  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        launchButton(
                          title: "Email",
                          icon: Icons.email,
                          onPressed: () async {
                            final email = userData['email'] ?? '';
                            if (email.isEmpty) {
                              debugPrint("Email address is empty");
                              return;
                            }
                            final Uri emailUri = Uri(
                              scheme: 'mailto',
                              path: email,
                            );
                            if (!await canLaunch(emailUri.toString())) {
                              debugPrint("Could not launch the email uri");
                            } else {
                              await launch(emailUri.toString());
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        launchButton(
                          title: "Phone Number",
                          icon: Icons.phone,
                          onPressed: () async {
                            final phoneNumber = userData['phoneNumber'] ?? '';
                            if (phoneNumber.isEmpty) {
                              debugPrint("Phone number is empty");
                              return;
                            }
                            final Uri phoneUri = Uri(
                              scheme: 'tel',
                              path: phoneNumber,
                            );
                            if (!await canLaunch(phoneUri.toString())) {
                              debugPrint("Could not launch the phone uri");
                            } else {
                              await launch(phoneUri.toString());
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget launchButton({
    required String title,
    required IconData icon,
    required Function() onPressed,
  }) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}