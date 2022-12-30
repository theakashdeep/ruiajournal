// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ruiajournal/auth_service.dart';
// import 'package:provider/provider.dart';

// class Home extends StatefulWidget {
//   const Home({Key key, this.currentUser}) : super(key: key);
//   final User currentUser;
//   // Home(this.currentUser);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   // final AuthService _auth = AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.blueGrey,
//         appBar: AppBar(
//           title: Text(
//             // "Ruia Journal ${widget.currentUser.email}",
//             "Ruia Journal",
//             style: TextStyle(fontSize: 25),
//           ),
//           centerTitle: true,
//         ),
//         body: StreamBuilder<DocumentSnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('admin')
//               .doc(widget.currentUser.uid)
//               .snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return Text("Error: ${snapshot.error}");
//             }
//             switch (snapshot.connectionState) {
//               case ConnectionState.waiting:
//                 return Text("Loading");
//               default:
//                 return Text(snapshot.data['name']);
//             }
//           },
//         )
//         // //Container ->
//         // //Column1 -> Image and Text
//         // //Column2 -> Three Rows -> Two cards in 1st, 2nd | Logout in 3rd
//         // //
//         // body: Container(
//         //   margin: EdgeInsets.only(top: 30),
//         //   // padding: new EdgeInsets.all(10),
//         //   child: Column(
//         //     children: [
//         //       CircleAvatar(
//         //         backgroundImage: AssetImage(
//         //           'assets/uk.png',
//         //         ),
//         //         radius: 70,
//         //       ),
//         //       SizedBox(
//         //         height: 20,
//         //       ),
//         //       Text(
//         //         'Akashdeep Singh',
//         //         style: TextStyle(fontSize: 20),
//         //       ),
//         //       SizedBox(
//         //         height: 10,
//         //       ),
//         //       Text(
//         //         'TYBSC Computer Science',
//         //         style: TextStyle(fontSize: 20),
//         //       ),
//         //       SizedBox(
//         //         height: 50,
//         //       ),

//         //       // Column with 3 rows
//         //       Column(
//         //         children: [
//         //           //Row 1 with 2 cards
//         //           Row(
//         //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         //             children: [
//         //               Container(
//         //                 height: 170,
//         //                 width: 150,
//         //                 child: new Card(
//         //                   elevation: 5,
//         //                   shape: RoundedRectangleBorder(
//         //                       borderRadius: BorderRadius.circular(15)),
//         //                   child: Container(
//         //                     padding: new EdgeInsets.all(20),
//         //                     child: new InkWell(
//         //                       onTap: () {
//         //                         print("Tapped");
//         //                       },
//         //                       //column
//         //                       child: Column(
//         //                         children: [
//         //                           Icon(
//         //                             Icons.airport_shuttle,
//         //                             size: 70,
//         //                           ),
//         //                           SizedBox(height: 20),
//         //                           Text(
//         //                             "Timetable",
//         //                             style: TextStyle(
//         //                                 fontSize: 20, color: Colors.purple),
//         //                           ),
//         //                         ],
//         //                       ),
//         //                     ),
//         //                   ),
//         //                 ),
//         //               ),
//         //               Container(
//         //                 height: 170,
//         //                 width: 150,
//         //                 child: new Card(
//         //                   elevation: 5,
//         //                   shape: RoundedRectangleBorder(
//         //                       borderRadius: BorderRadius.circular(15)),
//         //                   child: Container(
//         //                     padding: new EdgeInsets.all(20),
//         //                     child: new InkWell(
//         //                       onTap: () {
//         //                         print("Tapped");
//         //                       },
//         //                       child: Column(
//         //                         children: [
//         //                           Icon(
//         //                             Icons.airport_shuttle,
//         //                             size: 70,
//         //                           ),
//         //                           SizedBox(height: 20),
//         //                           Text(
//         //                             "Attendance",
//         //                             style: TextStyle(
//         //                                 fontSize: 20, color: Colors.purple),
//         //                           ),
//         //                         ],
//         //                       ),
//         //                     ),
//         //                   ),
//         //                 ),
//         //               ),
//         //             ],
//         //           ),
//         //           SizedBox(height: 10),
//         //           Row(
//         //             //Row 2 with 2 cards
//         //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         //             children: [
//         //               Container(
//         //                 height: 170,
//         //                 width: 150,
//         //                 child: new Card(
//         //                   elevation: 5,
//         //                   shape: RoundedRectangleBorder(
//         //                       borderRadius: BorderRadius.circular(15)),
//         //                   child: Container(
//         //                     padding: new EdgeInsets.all(20),
//         //                     child: new InkWell(
//         //                       onTap: () {
//         //                         print("Tapped");
//         //                       },
//         //                       //column
//         //                       child: Column(
//         //                         children: [
//         //                           Icon(
//         //                             Icons.airport_shuttle,
//         //                             size: 70,
//         //                           ),
//         //                           SizedBox(height: 20),
//         //                           Text(
//         //                             "Feedback",
//         //                             style: TextStyle(
//         //                                 fontSize: 20, color: Colors.purple),
//         //                             // backgroundColor: Colors.yellow),
//         //                           ),
//         //                         ],
//         //                       ),
//         //                     ),
//         //                   ),
//         //                 ),
//         //               ),
//         //               Container(
//         //                 height: 170,
//         //                 width: 150,
//         //                 child: new Card(
//         //                   elevation: 5,
//         //                   shape: RoundedRectangleBorder(
//         //                       borderRadius: BorderRadius.circular(15)),
//         //                   child: Container(
//         //                     padding: new EdgeInsets.all(20),
//         //                     child: new InkWell(
//         //                       onTap: () {
//         //                         print("Tapped");
//         //                       },
//         //                       child: Column(
//         //                         children: [
//         //                           Icon(
//         //                             Icons.airport_shuttle,
//         //                             size: 70,
//         //                           ),
//         //                           SizedBox(height: 20),
//         //                           Text(
//         //                             "Leave",
//         //                             style: TextStyle(
//         //                                 fontSize: 20, color: Colors.purple),
//         //                           ),
//         //                         ],
//         //                       ),
//         //                     ),
//         //                   ),
//         //                 ),
//         //               ),
//         //             ],
//         //           ),
//         //           SizedBox(height: 10),
//         //           Row(
//         //             //Row 3 with Logout Button
//         //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         //             children: [
//         //               new RaisedButton(
//         //                   // padding: EdgeInsets.all(20),
//         //                   child: Text('Logout'),
//         //                   color: Colors.red,
//         //                   textColor: Colors.white,
//         //                   elevation: 7,
//         //                   onPressed: () async {
//         //                     context.read<AuthenticationService>().signOut();
//         //                   }),
//         //             ],
//         //           ),
//         //         ],
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         );
//   }
// }
