import 'package:flutter/material.dart';
import '../variables.dart' as vr;
import '../windows/windows.dart';
import '../settings/settings.dart';
import '../addRoom/addRoom.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List rooms = [];

  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
    () => 'Data Loaded',
  );

  void fetchRooms() async {
    QuerySnapshot q = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('rooms')
        .get();
    rooms = q.docs.map((doc) => doc.data()).toList();
    print(rooms);
  }

  void initState() {
    fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _calculation,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (rooms.length > 0) {
          print("Hello");
          for (int i = 0; i < rooms.length; i++) {
            if (rooms[i]['roomName'] == 'Dummy') {
              rooms.remove(rooms[i]);
            }
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: vr.mainColour,
              leading: Image(image: AssetImage('lib/assets/img/logo.jpg')),
              title: Text(
                "Window Net",
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
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 20,
                  MediaQuery.of(context).size.height / 30,
                  MediaQuery.of(context).size.width / 20,
                  MediaQuery.of(context).size.height / 30,
                ),
                child: Column(
                  children: [
                    GridView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: rooms.length + 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index != rooms.length) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Windows(
                                    roomName: rooms[index]['roomName'],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: vr.mainColour,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width / 50,
                                  MediaQuery.of(context).size.height / 100,
                                  MediaQuery.of(context).size.width / 50,
                                  MediaQuery.of(context).size.width / 100,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      child: Text(
                                        rooms[index]['roomName'],
                                        style: TextStyle(
                                          color: vr.mainColour,
                                          fontFamily: vr.boldFont,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: Text(
                                        rooms[index]['temp'].toString() + "°C",
                                        style: TextStyle(
                                          color: vr.mainColour,
                                          fontFamily: vr.basicFont,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text(
                                              "AC",
                                              style: TextStyle(
                                                color: vr.mainColour,
                                                fontFamily: vr.basicFont,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10,
                                            child: Text(
                                              rooms[index]['numAC'].toString(),
                                              style: TextStyle(
                                                color: vr.mainColour,
                                                fontFamily: vr.basicFont,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text(
                                              "Window",
                                              style: TextStyle(
                                                color: vr.mainColour,
                                                fontFamily: vr.basicFont,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10,
                                            child: Text(
                                              rooms[index]['numWindow']
                                                  .toString(),
                                              style: TextStyle(
                                                color: vr.mainColour,
                                                fontFamily: vr.basicFont,
                                                fontSize: 20,
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
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => (AddRoom()),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: vr.mainColour,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.add_circle_outline,
                                      color: vr.mainColour,
                                      size: MediaQuery.of(context).size.height /
                                          20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        100,
                                  ),
                                  Container(
                                    child: Text(
                                      "Add Room",
                                      style: TextStyle(
                                        color: vr.mainColour,
                                        fontFamily: vr.basicFont,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}
