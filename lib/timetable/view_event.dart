import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // actions: [
          //   // IconButton(
          //   //   icon: Icon(Icons.edit),
          //   //   onPressed: () {},
          //   // ),
          //   IconButton(
          //     icon: Icon(Icons.delete),
          //     onPressed: () async {
          //       await showDialog(
          //           context: context,
          //           builder: (context) => AlertDialog(
          //                   title: Text("Warning!"),
          //                   content: Text("Are you sure?"),
          //                   actions: [
          //                     TextButton(
          //                       child: Text("Delete"),
          //                       onPressed: () async {
          //                         DocumentReference documentReference =
          //                             FirebaseFirestore.instance
          //                                 .collection("Timetable")
          //                                 .doc();
          //                         await documentReference.delete().whenComplete(
          //                             () => print("deleted event"));

          //                         Navigator.pop(context);
          //                         Navigator.pop(context);
          //                       },
          //                     ),
          //                     TextButton(
          //                       child: Text("Cancel"),
          //                       onPressed: () {
          //                         Navigator.pop(context, false);
          //                       },
          //                     ),
          //                   ]));
          //       // ??
          //       // false;
          //       // if (confirm) {
          //       // DocumentReference documentReference =
          //       //     FirebaseFirestore.instance.collection("Timetable").doc();
          //       // documentReference.delete();
          //       // print("deleted event");
          //       // }
          //     },
          //   ),
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Timetable")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.docs[index];
                        return Container(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.event),
                                title: Text(
                                  documentSnapshot['title'],
                                  style: TextStyle(fontSize: 25),
                                ),
                                subtitle: Text(DateFormat('EEEE, dd-MM-yyyy')
                                    .format(documentSnapshot['date'].toDate())),
                              ),
                              SizedBox(height: 10),
                              ListTile(
                                leading: Icon(Icons.short_text),
                                title: Text(documentSnapshot['details']),
                              )
                            ],
                          ),
                        );
                      });
                } else {
                  return Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
