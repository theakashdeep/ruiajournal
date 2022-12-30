/*
import 'package:bordered_text/bordered_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Timetable extends StatefulWidget {
  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(10),
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
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Timetable")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              SizedBox(height: 20),
                              Text("TimeTable",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              SizedBox(height: 10),
                              Card(
                                margin: const EdgeInsets.all(10),
                                clipBehavior: Clip.antiAlias,

                                // Table Calendar
                                child: TableCalendar(
                                  // Holidays
                                  weekendDays: [7],

                                  initialCalendarFormat: CalendarFormat.month,

                                  headerStyle: HeaderStyle(
                                    centerHeaderTitle: true,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    headerMargin:
                                        const EdgeInsets.only(bottom: 10),
                                    titleTextStyle: TextStyle(
                                        color: Colors.white, fontSize: 18),

                                    // Box Decoration
                                    formatButtonDecoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(5),
                                    ),

                                    // Button Style
                                    formatButtonTextStyle: TextStyle(
                                      color: Colors.white,
                                    ),

                                    // Left & Tight arrows
                                    leftChevronIcon: Icon(Icons.chevron_left,
                                        color: Colors.white),
                                    rightChevronIcon: Icon(Icons.chevron_right,
                                        color: Colors.white),
                                    formatButtonShowsNext: false,
                                  ),

                                  // startingDayOfWeek: ,
                                  // Calendar Style
                                  calendarStyle: CalendarStyle(
                                    todayColor: Colors.orange,
                                    selectedColor: Colors.purple,
                                    // Ctrl + Left Click to explore more options
                                  ),

                                  calendarController: _calendarController,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 128, right: 128, bottom: 5),
                                child: Divider(
                                    height: 50,
                                    thickness: 1.5,
                                    color: Colors.grey),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 0, 25, 0),
                                child: Container(
                                    child: BorderedText(
                                        child: Text(
                                  "Events",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ))),
                              ),
                              SizedBox(height: 20),
                              displayTimetableRecord(context, snapshot),
                            ],
                          );
                        } else {
                          return Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Container(child: CircularProgressIndicator(),)
                          );
                        }
                      })),
            ),
          );
        },
      ),
    );
  }

  Widget displayTimetableRecord(context, snapshot) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
            return Column(children: [
              ListTile(
                tileColor: Colors.transparent,
                title: Text(documentSnapshot['details'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[300])),
                subtitle: Text(
                    DateFormat('EEEE, dd-MM-yyyy')
                        .format(documentSnapshot['date'].toDate()),
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.grey[300])),
                onTap: () {
                  Navigator.pushNamed(context, "/viewEvent");
                },
              ),
            ]);
          }),
    );
  }
}
*/