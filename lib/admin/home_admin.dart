// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome ${widget.user.email}"),
        ),
        body: Container(
          color: Colors.black,
          child: Text("Welocome"),
        )
        // body: StreamBuilder<DocumentSnapshot>(
        //   stream: FirebaseFirestore.instance
        //       .collection('admin')
        //       .doc(user.uid)
        //       .snapshots(),
        //   builder:
        //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //     if (snapshot.hasError) {
        //       return Text("Error: ${snapshot.error}");
        //     }
        //     switch (snapshot.connectionState) {
        //       case ConnectionState.waiting:
        //         return Text("Loading...");
        //       default:
        //         // return Text(snapshot.data["name"]);
        //         return checkRole(snapshot.data);
        //     }
        //   },
        // )
        );
  }
}
