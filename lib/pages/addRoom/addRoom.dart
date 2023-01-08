import 'package:flutter/material.dart';
import '../variables.dart' as vr;
import '../windows/windows.dart';
import '../settings/settings.dart';
import '../../widgets/inputBox.dart';
import '../dashboard/dashboard.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  TextEditingController roomname = TextEditingController();
  TextEditingController roomid = TextEditingController();

  void addRoom() async {
    CollectionReference _cref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('rooms');
    await _cref.doc(roomname.text).set({
      'roomCode': roomid.text,
      'roomName': roomname.text,
      'numAC': 0,
      'numWindow': 0,
      'temp': 0,
      'humidity': 0,
    });
    await _cref
        .doc(roomname.text)
        .collection('acs')
        .doc('Dummy')
        .set({'acName': 'Dummy'});
    await _cref
        .doc(roomname.text)
        .collection('windows')
        .doc('Dummy')
        .set({'windowName': 'Dummy'});
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
          "Add Room",
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
                          "Add Room",
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
                          "Room Name",
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
                          controller: roomname,
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
                          "Room Code",
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
                          controller: roomid,
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
                        onTap: () async {
                          addRoom();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()));
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
                                "Add Room",
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
