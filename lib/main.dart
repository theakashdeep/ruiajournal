import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ruiajournal/authentication/auth_service.dart';
import 'package:ruiajournal/startup/login.dart';
// import 'package:ruiajournal/startup/explore.dart';
import 'package:ruiajournal/startup/welcome.dart';
import 'package:ruiajournal/timetable/view_event.dart';
import 'home_student.dart';
import 'package:ruiajournal/authentication/provider_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: "Ruia Journal",
        debugShowCheckedModeBanner: false,
        home: Welcome(),
        routes: <String, WidgetBuilder>{
          "/welcome": (BuildContext context) => Welcome(),
          // "/explore": (BuildContext context) => Explore(),
          "/login": (BuildContext context) =>
              Login(authFormType: AuthFormType.login),
          "/home": (BuildContext context) => Home(),
          "/viewEvent": (BuildContext context) => EventDetails(),
        },
      ),
    );
  }
}
