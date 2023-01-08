import 'package:flutter/material.dart';
import '../variables.dart' as vr;
import '../../widgets/inputBox.dart';
import '../signupPage/signupScreen.dart';
import '../dashboard/dashboard.dart';
import '../../auth/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vr.mainColour,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 12,
                0, MediaQuery.of(context).size.width / 12, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    image: AssetImage('lib/assets/img/logo.jpg'),
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 15,
                    child: Center(
                      child: Text(
                        "Window Net",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: vr.basicFont,
                          fontSize: 32,
                        ),
                      ),
                    )),
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
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 20,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: vr.basicFont,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 30,
                  child: Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: vr.basicFont,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 20,
                  child: TextFormField(
                    autofocus: false,
                    obscureText: false,
                    controller: userName,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 35.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: vr.basicFont,
                      fontSize: 24,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 30,
                  child: Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: vr.basicFont,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 20,
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Password is required' : null,
                    controller: password,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 35.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: vr.basicFont,
                      fontSize: 24,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                GestureDetector(
                  onTap: () {
                    AuthService().signIn(userName.text, password.text, context);
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 20,
                      decoration: BoxDecoration(
                        color: Color(0xFFB9D8E9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontFamily: vr.basicFont,
                            fontSize: 24,
                            color: vr.mainColour,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontFamily: vr.basicFont,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        child: Text(
                          "Sign up!",
                          style: TextStyle(
                            fontFamily: vr.basicFont,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                            color: Color(0xFFB9D8E9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
