import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ruiajournal/authentication/provider_widget.dart';

class Profile extends StatelessWidget {
  // final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    // return ListView(itemExtent: 5000, children: [
    return SingleChildScrollView(
      child: Container(
        color: Colors.red[500],
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // return Text("${snapshot.data.email}");
                  return displayUserInfo(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget displayUserInfo(context, snapshot) {
    final user = snapshot.data;

    // users, document id, profile, document id,
    final collection = FirebaseFirestore.instance
        .collection("users")
        .doc("uid")
        .collection("profile")
        .doc("uid");

    return Padding(
      padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/ruia.jpeg"),
              radius: 40,
            ),
          ),
          SizedBox(height: 30),
          Text("Name", style: TextStyle(color: Colors.black, letterSpacing: 2)),
          Text("Akashdeep Singh",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20),
          Text("Age", style: TextStyle(color: Colors.black, letterSpacing: 2)),
          Text("21",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20),
          Text("Gender",
              style: TextStyle(color: Colors.black, letterSpacing: 2)),
          Text("Male",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20),
          Text("Student ID",
              style: TextStyle(color: Colors.black, letterSpacing: 2)),
          Text("765986",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20),
          Text("Class",
              style: TextStyle(color: Colors.black, letterSpacing: 2)),
          Text("TyBSc",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20),
          Text("Stream",
              style: TextStyle(color: Colors.black, letterSpacing: 2)),
          Text("Computer Science",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20),
          Text("Roll Number",
              style: TextStyle(color: Colors.black, letterSpacing: 2)),
          Text("7923",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20),
          Text("Category",
              style: TextStyle(color: Colors.black, letterSpacing: 2)),
          Text("General",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20),
          Text("Religion",
              style: TextStyle(color: Colors.black, letterSpacing: 2)),
          Text("Sikh",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.email, color: Colors.black),
              Text("akash@gmail.com",
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2,
                    // fontSize: 20,
                    // fontWeight: FontWeight.bold,
                  )),
            ],
          ),

          SizedBox(height: 20),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child:
          //       // Text("Name: ${user.displayName}", style: TextStyle(fontSize: 20)),
          //       Text("Name: Akashdeep Singh", style: TextStyle(fontSize: 20)),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text("Email: ${user.email}", style: TextStyle(fontSize: 20)),
          // ),
          // Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Image.asset("assets/ruia.jpeg"))
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //       "Created: ${DateFormat('dd/MM/yyyy').format(user.metadata.creationTime)}",
          //       style: TextStyle(fontSize: 20)),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text("${collection.get}", style: TextStyle(fontSize: 20)),
          // ),
        ],
      ),
    );
  }
}
