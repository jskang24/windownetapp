import 'package:flutter/material.dart';
import '../variables.dart' as vr;
import '../loginPage/loginPage.dart';
import 'dart:async';
import '../../auth/authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initState() {
    Timer(Duration(milliseconds: 3000), () {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AuthService().handleAuth()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Scaffold(
          backgroundColor: vr.mainColour,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('lib/assets/img/logo.jpg'),
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              Container(
                child: Text(
                  "Close, Change, Save, and Sustain",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: vr.specialFont,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
