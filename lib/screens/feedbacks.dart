import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:ruiajournal/authentication/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feedbacks extends StatefulWidget {
  @override
  _FeedbacksState createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {
  final formKey = new GlobalKey();

  List<String> _teachers = [
    "Rasika Munde",
    "Edith Michael",
    "Megha Sawant",
    "Pooja Rasam",
    "Kiran Prajapati",
    "Priyanka Vaddepalli",
    "Mahavir Advaya",
  ];
  String _selectedTeacher = "";

  // VALIDATION CHECK
  // bool validate() {
  //   final form = formKey.currentState;
  //   form.save();
  //   if (form.validate()) {
  //     form.save();
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  String selectedTeacher, studentFeedback;
  getSelectedTeacher(teacher) {
    this.selectedTeacher = teacher;
  }

  getStudentFeedback(feedback) {
    this.studentFeedback = feedback;
  }

  submitFeedback() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Feedback Record").doc();

    Map<String, dynamic> students = {
      "teacher": selectedTeacher,
      "feedback": studentFeedback,
    };

    documentReference.set(students).whenComplete(() {
      print("$studentFeedback feedback reason recorded");
    });
  }

  readLeave() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Students").doc();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    // _saveForm() {
    //   var form = formKey.currentState;
    //   if(form.validate()){
    //     form.save();
    //     setState((){_myActivityResult = _myActivity;)
    //   }
    // }

    return Scaffold(body: new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Form(
                child: Column(
              children: [
                Text(
                  "Provide Feedback",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                // SizedBox(height: 10),
                // Text(
                //   "Feedbacks are anonymous",
                //   style: TextStyle(
                //     fontSize: 18,
                //     color: Colors.white,
                //   ),
                // ),
                SizedBox(height: 30),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  child: new DropdownButtonFormField<String>(
                    items: _teachers.map((String val) {
                      return new DropdownMenuItem<String>(
                        value: val,
                        child: new Text(val),
                      );
                    }).toList(),
                    onChanged: (val) {
                      getSelectedTeacher(val);
                      setState(() {
                        _selectedTeacher = val;
                        this.setState(() {});
                      });
                    },
                    hint: _selectedTeacher == null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_selectedTeacher),
                          )
                        : Text("  Select a teacher"),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: inputDecoration("Feedback"),
                  maxLines: 5,
                  onChanged: (String feedback) {
                    getStudentFeedback(feedback);
                  },
                  validator: NameValidator.validate,
                ),
                SizedBox(height: 30),
                RaisedButton(
                  onPressed: () {
                    submitFeedback();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.white,
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 125, right: 125),
                  child:
                      Divider(height: 50, thickness: 1.5, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Container(
                      child: BorderedText(
                    child: Text("All Feedbacks",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  )),
                ),
                SizedBox(height: 10),
                FutureBuilder(builder: (context, snapshot) {
                  return displayFeedbackRecord(context, snapshot);
                })
              ],
            )),
          ),
        ),
      ));
    }));
  }

  Widget displayFeedbackRecord(context, snapshot) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Feedback Record")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        tileColor: Colors.transparent,
                        title: Text(documentSnapshot["teacher"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        subtitle: Text(documentSnapshot["feedback"],
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
        });
  }

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
