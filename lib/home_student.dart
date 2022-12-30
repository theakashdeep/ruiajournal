import 'package:flutter/material.dart';
// import 'package:ruiajournal/screens/attendance.dart';
import 'package:ruiajournal/screens/feedbacks.dart';
import 'package:ruiajournal/screens/leave.dart';
import 'package:ruiajournal/screens/profile.dart';
// import 'package:ruiajournal/timetable/timetable_new.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    Leave(),
    // Timetable(),
    Profile(),
    //Attendance(),
    Feedbacks(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ruia Journal"),
        backgroundColor: Color(0xFF2661FA),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.yellow,
        onTap: onTabTapped,

        //Page Number
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.hotel),
            label: "Leave",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today_sharp),
            label: "TimeTable",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_circle),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.done_all),
            label: "Attendance",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.feedback),
            label: "Feedback",
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
