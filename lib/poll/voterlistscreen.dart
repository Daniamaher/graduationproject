

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/poll/voterinfo.dart';
import 'package:flutter_application_1/toutring/visitprofile.dart';
class VotersListScreen extends StatelessWidget {
  final List<VoterInfo> voterInfoList;

  VotersListScreen({required this.voterInfoList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text(
          'Voters List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView.builder(
        itemCount: voterInfoList.length,
        itemBuilder: (context, index) {
          final voterInfo = voterInfoList[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(voterInfo.profileImageUrl),
              ),
              title: Text(
                voterInfo.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VistingProfileScreen(
                      studentId: voterInfo.IDNumber,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}