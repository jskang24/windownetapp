import 'package:flutter/material.dart';
import '../variables.dart' as vr;
import '../windows/windows.dart';
import '../settings/settings.dart';
import '../../widgets/inputBox.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AddAC extends StatefulWidget {
  String roomName = "";
  int acCnt = 0;

  AddAC({required this.roomName, required this.acCnt});

  @override
  State<AddAC> createState() => _AddACState();
}

class _AddACState extends State<AddAC> {
  TextEditingController acname = TextEditingController();
  TextEditingController acid = TextEditingController();

  void addAC() async {
    CollectionReference _cref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('rooms')
        .doc(widget.roomName)
        .collection('acs');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('rooms')
        .doc(widget.roomName)
        .collection('acs')
        .doc(acname.text)
        .set({
      'acCode': acid.text,
      'acName': acname.text,
      'status': false,
    });
    CollectionReference _cref2 = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('rooms');
    await _cref2.doc(widget.roomName).update({'numAC': widget.acCnt + 1});
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Windows(
                  roomName: widget.roomName,
                )));
  }

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
          "Add AC",
          style: TextStyle(
            fontFamily: vr.basicFont,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppSettings()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.height / 30 * 28,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: vr.mainColour,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 15,
                    MediaQuery.of(context).size.width / 30,
                    MediaQuery.of(context).size.width / 15,
                    MediaQuery.of(context).size.width / 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(
                          Icons.add_circle_outline,
                          color: vr.mainColour,
                          size: MediaQuery.of(context).size.height / 20,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Add AC",
                          style: TextStyle(
                            fontFamily: vr.basicFont,
                            fontSize: 20,
                            color: vr.mainColour,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 30,
                        child: Text(
                          "AC Name",
                          style: TextStyle(
                            color: vr.mainColour,
                            fontFamily: vr.boldFont,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 20,
                        child: TextFormField(
                          controller: acname,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 35.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: vr.mainColour,
                                width: 3.0,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: vr.mainColour),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: vr.mainColour),
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
                          "AC Code",
                          style: TextStyle(
                            color: vr.mainColour,
                            fontFamily: vr.boldFont,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 20,
                        child: TextFormField(
                          controller: acid,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 35.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: vr.mainColour,
                                width: 3.0,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: vr.mainColour),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: vr.mainColour),
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
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          addAC();
                        },
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 20,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: vr.mainColour, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Add AC",
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
                    ],
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
