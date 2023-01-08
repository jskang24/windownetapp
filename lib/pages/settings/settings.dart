import 'package:flutter/material.dart';
import '../variables.dart' as vr;
import '../../auth/authentication.dart';
import '../loginPage/loginPage.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: vr.mainColour,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            fontFamily: vr.basicFont,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 15,
              child: Text(
                "Settings",
                style: TextStyle(
                  fontFamily: vr.boldFont,
                  fontSize: 36,
                  color: vr.mainColour,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 20,
              child: Text(
                "Account Settings",
                style: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 20,
                  color: vr.mainColour,
                ),
              ),
            ),
            Divider(thickness: 1, height: 1, color: vr.mainColour),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            Container(
              height: MediaQuery.of(context).size.height / 20,
              child: Text(
                "Password Settings",
                style: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 20,
                  color: vr.mainColour,
                ),
              ),
            ),
            Divider(thickness: 1, height: 1, color: vr.mainColour),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            Container(
              height: MediaQuery.of(context).size.height / 20,
              child: Text(
                "Subscription Plan",
                style: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 20,
                  color: vr.mainColour,
                ),
              ),
            ),
            Divider(thickness: 1, height: 1, color: vr.mainColour),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            Container(
              height: MediaQuery.of(context).size.height / 20,
              child: Text(
                "Notice Board",
                style: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 20,
                  color: vr.mainColour,
                ),
              ),
            ),
            Divider(thickness: 1, height: 1, color: vr.mainColour),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            Container(
              height: MediaQuery.of(context).size.height / 20,
              child: Text(
                "Help",
                style: TextStyle(
                  fontFamily: vr.basicFont,
                  fontSize: 20,
                  color: vr.mainColour,
                ),
              ),
            ),
            Divider(thickness: 1, height: 1, color: vr.mainColour),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            GestureDetector(
              onTap: () {
                AuthService().signOut();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    fontFamily: vr.basicFont,
                    fontSize: 20,
                    color: vr.mainColour,
                  ),
                ),
              ),
            ),
            Divider(thickness: 1, height: 1, color: vr.mainColour),
          ],
        ),
      ),
    );
  }
}
