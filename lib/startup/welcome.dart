import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ruiajournal/startup/login.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      width: _width,
      height: _height,
      color: Colors.blue,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: _height * .15),
              AutoSizeText("WELCOME",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 50, color: Colors.white)),
              SizedBox(height: _height * .10),
              AutoSizeText("Ramnarain Ruia Autonomous College",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35)),
              SizedBox(height: _height * .15),

              // Button to Navigate to Explore Page without Logging in
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/explore");
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text("Explore",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: _height * .05),

              //Button to Login
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/login");
                  
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
