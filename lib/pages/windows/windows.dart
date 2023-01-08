import 'package:flutter/material.dart';
import '../variables.dart' as vr;
import '../settings/settings.dart';
import '../addAC/addAC.dart';
import '../addWindow/addWindow.dart';
import '../dashboard/dashboard.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Windows extends StatefulWidget {
  String roomName = "";

  Windows({
    required this.roomName,
  });

  @override
  State<Windows> createState() => _WindowsState();
}

class _WindowsState extends State<Windows> {
  List roomData = [];
  List windows = [];
  List acs = [];

  void getData() async {
    QuerySnapshot q = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('rooms')
        .get();
    q.docs
        .map((doc) =>
            {if (doc['roomName'] == widget.roomName) roomData.add(doc.data())})
        .toList();
    print(roomData);
    QuerySnapshot q2 = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('rooms')
        .doc(widget.roomName)
        .collection('windows')
        .get();
    windows = q2.docs.map((doc) => doc.data()).toList();

    QuerySnapshot q3 = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('rooms')
        .doc(widget.roomName)
        .collection('acs')
        .get();
    acs = q3.docs.map((doc) => doc.data()).toList();
  }

  void initState() {
    getData();
  }

  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 3),
    () => 'data loaded',
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _calculation,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (windows.length > 0) {
          if (acs.length > 0) {
            for (int i = 0; i < acs.length; i++) {
              if (acs[i]['acName'] == "Dummy") {
                acs.remove(acs[i]);
              }
            }
            for (int i = 0; i < windows.length; i++) {
              if (windows[i]['windowName'] == "Dummy") {
                windows.remove(windows[i]);
              }
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: vr.mainColour,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                ),
                title: Row(
                  children: [
                    Text(
                      widget.roomName + " Status",
                      style: TextStyle(
                        fontFamily: vr.basicFont,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 15,
                        child: Text(
                          widget.roomName,
                          style: TextStyle(
                            fontFamily: vr.boldFont,
                            fontSize: 36,
                            color: vr.mainColour,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width /
                                      30 *
                                      14,
                                  child: Text(
                                    "Temperature",
                                    style: TextStyle(
                                      fontFamily: vr.boldFont,
                                      fontSize: 24,
                                      color: vr.mainColour,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    roomData[0]['temp'].toString() + "°C",
                                    style: TextStyle(
                                      fontFamily: vr.boldFont,
                                      fontSize: 50,
                                      color: vr.mainColour,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width /
                                      30 *
                                      14,
                                  child: Text(
                                    "Humidity",
                                    style: TextStyle(
                                      fontFamily: vr.boldFont,
                                      fontSize: 24,
                                      color: vr.mainColour,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    roomData[0]['humidity'].toString() + "%",
                                    style: TextStyle(
                                      fontFamily: vr.boldFont,
                                      fontSize: 50,
                                      color: vr.mainColour,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 100),
                      Container(
                        child: Text(
                          "Air Conditioner",
                          style: TextStyle(
                            fontFamily: vr.boldFont,
                            fontSize: 24,
                            color: vr.mainColour,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 100),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: roomData[0]['numAC'] + 1,
                            itemBuilder: (context, index) {
                              if (index != roomData[0]['numAC']) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      width:
                                          MediaQuery.of(context).size.height /
                                              30 *
                                              28,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 3,
                                          color: vr.mainColour,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            acs[index]['acName'],
                                            style: TextStyle(
                                              fontFamily: vr.boldFont,
                                              fontSize: 20,
                                              color: vr.mainColour,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100,
                                    ),
                                  ],
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => (AddAC(
                                          roomName: widget.roomName,
                                          acCnt: roomData[0]['numAC'],
                                        )),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 3,
                                        color: vr.mainColour,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            color: vr.mainColour,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50),
                      Container(
                        child: Text(
                          "Windows",
                          style: TextStyle(
                            fontFamily: vr.boldFont,
                            fontSize: 24,
                            color: vr.mainColour,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 100),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: roomData[0]['numWindow'] + 1,
                            itemBuilder: (context, index) {
                              if (index != roomData[0]['numWindow']) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      width: MediaQuery.of(context).size.width /
                                          30 *
                                          28,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 3,
                                          color: vr.mainColour,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                60,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                60 *
                                                26,
                                            child: Text(
                                              windows[index]['windowName']
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: vr.boldFont,
                                                fontSize: 20,
                                                color: vr.mainColour,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                60 *
                                                25,
                                            child: Text(
                                              windows[index]['status'] ==
                                                      "false"
                                                  ? "OPENED"
                                                  : "CLOSED",
                                              style: TextStyle(
                                                fontFamily: vr.basicFont,
                                                fontSize: 20,
                                                color: windows[index]
                                                            ['status'] ==
                                                        "false"
                                                    ? vr.mainColour
                                                    : Color(0xFFB9D8E9),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                60,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100,
                                    ),
                                  ],
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => (AddWindow(
                                          roomName: widget.roomName,
                                          windowCnt: roomData[0]['numWindow'],
                                        )),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 3,
                                        color: vr.mainColour,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            color: vr.mainColour,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold();
          }
        } else {
          return Scaffold();
        }
      },
    );
  }
}
