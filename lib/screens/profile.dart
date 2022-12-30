import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ruiajournal/authentication/provider_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ruiajournal/authentication/auth_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bordered_text/bordered_text.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  List<Widget> containers = [
    Container(color: Colors.black),
    Container(color: Colors.white),
    Container(color: Colors.brown),
  ];

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              FutureBuilder(
                future: Provider.of(context).auth.getCurrentUID(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return displayUserInfo(context, snapshot);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ));
    }));
  }

  Widget displayUserInfo(context, snapshot) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Students").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = snapshot.data.docs[index];

                  return SingleChildScrollView(
                    child: Container(
                      height: _height,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            Container(
                              height: _height * 0.30,
                              child: Stack(
                                children: [
                                  LayoutBuilder(
                                      builder: (context, constraints) {
                                    double innerHeight = constraints.maxHeight;
                                    double innerWidth = constraints.maxWidth;
                                    return Stack(
                                      children: [
                                        Positioned(
                                          bottom: 20,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            height: innerHeight * 0.72,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: innerHeight * 0.31,
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                    documentSnapshot[
                                                        "studentName"],
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          39, 105, 171, 1),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        innerHeight * 0.045),
                                                Stack(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text("Roll",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700])),
                                                            SizedBox(
                                                              child: Text(
                                                                // "     " +
                                                                documentSnapshot[
                                                                    "studentID"],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          39,
                                                                          105,
                                                                          171,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      25,
                                                                  vertical:
                                                                      4.5),
                                                          child: Container(
                                                            width: 4,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.grey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text("Stream",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700])),
                                                            SizedBox(
                                                              child: Text(
                                                                documentSnapshot[
                                                                    "studentStream"],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          39,
                                                                          105,
                                                                          171,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                              ],
                                            ),
                                          ),
                                        ),

                                        // BUILDING IMAGE
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          child: Center(
                                            child: Container(
                                              height: innerWidth * 0.35,
                                              width: innerWidth * 0.35,
                                              child: CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/main.jpg"),
                                                radius: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),

                            // CREATING TABVIEW
                            Container(
                              height: _height * 0.462,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    child: TabBar(
                                      labelColor: Colors.red,
                                      unselectedLabelColor: Colors.black,
                                      labelStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      tabs: [
                                        Tab(text: "Personal"),
                                        Tab(text: "Settings"),
                                      ],
                                      controller: _tabController,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                    ),
                                  ),

                                  // FETCHING USER DATA IN TABVIEW
                                  Expanded(
                                      child: TabBarView(
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 18, 25, 0),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text("Name: \t\t\t",
                                                                style:
                                                                    textStyle()),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text("Age: \t\t\t",
                                                                style:
                                                                    textStyle()),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text("Gender: \t",
                                                                style:
                                                                    textStyle()),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text(
                                                                "DOB: \t\t\t\t\t",
                                                                style:
                                                                    textStyle()),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text(
                                                                "Year: \t\t\t\t\t",
                                                                style:
                                                                    textStyle()),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text("Stream:  ",
                                                                style:
                                                                    textStyle()),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text("Mobile:  ",
                                                                style:
                                                                    textStyle()),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text("Email:    ",
                                                                style:
                                                                    textStyle()),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 7),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              documentSnapshot[
                                                                  "studentName"],
                                                              style:
                                                                  textStyleData(),
                                                            ),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text(
                                                              documentSnapshot[
                                                                      "studentAge"]
                                                                  .toString(),
                                                              style:
                                                                  textStyleData(),
                                                            ),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text(
                                                              documentSnapshot[
                                                                  "studentGender"],
                                                              style:
                                                                  textStyleData(),
                                                            ),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text(
                                                              documentSnapshot[
                                                                  "studentDOB"],
                                                              style:
                                                                  textStyleData(),
                                                            ),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text(
                                                              documentSnapshot[
                                                                  "studentYear"],
                                                              style:
                                                                  textStyleData(),
                                                            ),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text(
                                                              documentSnapshot[
                                                                  "studentStream"],
                                                              style:
                                                                  textStyleData(),
                                                            ),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text(
                                                              documentSnapshot[
                                                                      "studentMobile"]
                                                                  .toString(),
                                                              style:
                                                                  textStyleData(),
                                                            ),
                                                            Divider(
                                                                height: 18,
                                                                thickness: 2,
                                                                color: Colors
                                                                    .black),
                                                            Text(
                                                              documentSnapshot[
                                                                  "studentEmail"],
                                                              style:
                                                                  textStyleData(),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 18, 25, 0),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: _width * 0.5,
                                                height: _height * 0.06,
                                                child: Card(
                                                  color: Colors.blue,
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: InkWell(
                                                    splashColor: Colors.yellow,
                                                    onTap: () async {
                                                      try {
                                                        AuthService auth =
                                                            Provider.of(context)
                                                                .auth;
                                                        await auth.signOut();
                                                        Navigator.of(context)
                                                            .pushNamedAndRemoveUntil(
                                                                "/login",
                                                                (Route<dynamic>
                                                                        route) =>
                                                                    false);
                                                        print(
                                                            "Signed out successfully");
                                                      } catch (e) {
                                                        print(
                                                            "THIS WAS THE ERROR: $e");
                                                      }
                                                    },
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          AutoSizeText(
                                                            "Logout",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
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
                                    controller: _tabController,
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return Container(
            color: Colors.black,
          );
        },
      ),
    );
  }

  TextStyle textStyle() {
    return TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: Colors.grey[500],
    );
  }

  TextStyle textStyleData() {
    return TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.cover,
      );
    });
    return image;
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
