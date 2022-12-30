/*
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
  const Attendance({Key key}) : super(key: key);
}

class _AttendanceState extends State<Attendance> {
  TextEditingController _textEditingController = new TextEditingController();
  dynamic result = "";
  dynamic errorResult = "";
  dynamic yearOfStudy = "";
  dynamic selectedTeacher = "";
  dynamic selectedSubject = "";
  String headerText = "Mark your attendance here";

  dynamic currentDateTime =
      DateFormat("h:mm a - dd-MM-yyyy").format(DateTime.now());

  Future scanQR() async {
    try {
      String result = await BarcodeScanner.scan();
      setState(() {
        this.result = result;
        print("Just scanned $result");
        final newResult = result.split(",");
        final Map<int, String> values = {
          for (int i = 0; i < newResult.length; i++) i: newResult[i]
        };

        yearOfStudy = values[0];
        selectedTeacher = values[1];
        selectedSubject = values[2];
        print(yearOfStudy);
        createAttendance();
        headerText = "Your attendance has been marked!";
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $e";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button";
      });
    } catch (e) {
      setState(() {
        result = "Unknown Error $e";
      });
    }
  }

  getSelectedTeacher(teacher) {
    this.selectedTeacher = teacher;
  }

  getSelectedStudent(subject) {
    this.selectedSubject = subject;
  }

  Future createAttendance() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Attendance").doc();

    Map<String, dynamic> attendance = {
      "studentName": "Akashdeep",
      "selectedTeacher": selectedTeacher,
      "selectedSubject": selectedSubject,
      "dateTime": currentDateTime,
    };

    documentReference.set(attendance).whenComplete(() {
      print("$attendance created");
      print("Printing $yearOfStudy $selectedSubject $selectedTeacher");
    });
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              // color: Colors.lightBlue,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(4, 9, 35, 1),
                    Color.fromRGBO(39, 105, 171, 1),
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child:
                  ListView(physics: NeverScrollableScrollPhysics(), children: [
                Column(
                  children: [
                    Text("Attendance",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white)),
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.32,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              alignment: Alignment.center,
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          child: Row(
                            children: [
                              Icon(Icons.camera, color: Colors.black),
                              SizedBox(width: 10),
                              Text(
                                "Scan",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          onPressed: () {
                            scanQR();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 125, right: 125),
                      child: Divider(
                          height: 100, thickness: 1.5, color: Colors.grey),
                    ),
                    attendanceCheck(),
                    SizedBox(height: 50),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Professor:" + selectedTeacher,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Subject:" + selectedSubject,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Time: " + currentDateTime,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 125, right: 125),
                      child: Divider(
                          height: 100, thickness: 1.5, color: Colors.grey),
                    ),
                    Text(
                      "Marked Attendance",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    FutureBuilder(builder: (context, snapshot) {
                      return displayAttendanceRecord(context, snapshot);
                    }),
                  ],
                ),
              ]),
            ),
          ),
          // )
        );
      }),
    );
  }

  Widget displayAttendanceRecord(context, snapshot) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("Attendance").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.docs[index];
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ListTile(
                          tileColor: Colors.transparent,
                          title: Text(documentSnapshot["selectedSubject"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          subtitle: Row(
                            children: [
                              Text(documentSnapshot["selectedTeacher"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[300])),
                              SizedBox(width: 10),
                              Text(documentSnapshot["dateTime"].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[300])),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            } else {
              return Align(
                alignment: FractionalOffset.bottomCenter,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  // HEADER TEXT
  AutoSizeText attendanceCheck() {
    return AutoSizeText(
      headerText,
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      textAlign: TextAlign.center,
    );
  }
}
*/