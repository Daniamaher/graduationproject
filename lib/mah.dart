import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VisitingProfileScreen extends StatelessWidget {
  final String email = 'szdania20@cit.just.edu.jo';
  final String phoneNumber = '0796054799';

  const VisitingProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F3F3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            launchButton(
              title: "Email",
              icon: Icons.email,
              onPressed: () async {
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
            SizedBox(height: 20),
            launchButton(
              title: "Phone Number",
              icon: Icons.phone,
              onPressed: () async {
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
          ],
        ),
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
          backgroundColor: MaterialStateProperty.all(Colors.teal), // Use kPrimaryColor if defined
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
