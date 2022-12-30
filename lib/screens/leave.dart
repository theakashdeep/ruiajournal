import 'package:bordered_text/bordered_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:ruiajournal/authentication/auth_service.dart';

class Leave extends StatefulWidget {
  @override
  _LeaveState createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  final formKey = GlobalKey<FormState>();

  // VALIDATION CHECK
  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  String studentName, studentRoll, leaveDuration, leaveReason, leaveTime;
  String _dateCount, _range;

  getStudentRoll(roll) {
    this.studentRoll = roll;
  }

  getDuration(duration) {
    this.leaveDuration = duration;
  }

  getReason(reason) {
    this.leaveReason = reason;
  }

  submitLeave() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Leave Record").doc(studentRoll);

    Map<String, dynamic> students = {
      "leaveDuration": _range,
      "leaveReason": leaveReason,
    };

    documentReference.set(students).whenComplete(() {
      print("$studentName leave reason recorded");
    });
    getDuration(leaveDuration);
  }

  readLeave() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Students").doc();
  }

  void initState() {
    _dateCount = "";
    _range = "";
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
        child: SingleChildScrollView(
          child: Container(
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Form(
                      child: Column(
                    children: [
                      Text(
                        "Request leave",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Leave is subject to approval by your HOD",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),

                      SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                        initialSelectedRange: PickerDateRange(
                          DateTime.now().add(const Duration(days: 1)),
                          DateTime.now().add(const Duration(days: 3)),
                        ),
                        backgroundColor: Colors.white,
                        selectionColor: Colors.orange,
                        selectionTextStyle: TextStyle(
                            fontSize: 17,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        todayHighlightColor: Colors.orange,
                        headerStyle: DateRangePickerHeaderStyle(
                            backgroundColor: Colors.red,
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              letterSpacing: 1,
                              color: Colors.white,
                            )),
                        monthViewSettings:
                            DateRangePickerMonthViewSettings(dayFormat: 'EEE'),
                      ),

                      //
                      SizedBox(height: 10),
                      Container(
                          child: Text(
                        "Selected dates: " + _range + _dateCount,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: inputDecoration("Reason"),
                        onChanged: (String reason) {
                          getReason(reason);
                        },
                        validator: NameValidator.validate,
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () {
                          submitLeave();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.white,
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 145, right: 145),
                  child:
                      Divider(height: 50, thickness: 1.5, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Container(
                    child: BorderedText(
                        child: Text(
                      "Previous Requests",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
                FutureBuilder(builder: (context, snapshot) {
                  return displayLeaveRecord(context, snapshot);
                })
              ],
            ),
          ),
        ),
      );
    }));
  }

  Widget displayLeaveRecord(context, snapshot) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("Leave Record").snapshots(),
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
                          title: Text(documentSnapshot["leaveReason"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          subtitle: Text(
                              documentSnapshot["leaveDuration"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[300])),
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

  // TextBox Styling
  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0)),
      contentPadding: const EdgeInsets.only(left: 14, bottom: 10, top: 10),
    );
  }
}
