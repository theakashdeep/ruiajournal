/*
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class Timetable extends StatefulWidget {
  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  CalendarController _calendarController = CalendarController();
  // CalendarController();
  TextEditingController _eventController;

  Map<DateTime, List<dynamic>> _events;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _events = {};
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<DateTime, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      // newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
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
                color: Colors.white,
                // alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Text("TimeTable",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Card(
                        margin: const EdgeInsets.all(10),
                        clipBehavior: Clip.antiAlias,

                        // Table Calendar
                        child: TableCalendar(
                          events: _events,

                          // Holidays
                          weekendDays: [7],

                          initialCalendarFormat: CalendarFormat.week,

                          headerStyle: HeaderStyle(
                            centerHeaderTitle: true,
                            decoration: BoxDecoration(
                              color: Colors.red,
                            ),
                            headerMargin: const EdgeInsets.only(bottom: 10),
                            titleTextStyle:
                                TextStyle(color: Colors.white, fontSize: 18),

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
                            leftChevronIcon:
                                Icon(Icons.chevron_left, color: Colors.white),
                            rightChevronIcon:
                                Icon(Icons.chevron_right, color: Colors.white),
                            formatButtonShowsNext: false,
                          ),

                          // startingDayOfWeek: ,
                          // Calendar Style
                          calendarStyle: CalendarStyle(
                            todayColor: Colors.orange,
                            selectedColor: Colors.purple,
                            // Ctrl + Left Click to explore more options
                          ),

                          // Calendar Builder
                          // builders: CalendarBuilders(
                          //     selectedDayBuilder: (context, date, events) =>
                          //         Container(

                          //         )),

                          calendarController: _calendarController,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),

      // Button
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("/addEvent");
          }),
    );
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          content: TextField(controller: _eventController),
          actions: <Widget>[
            FlatButton(
                child: Text("Save"),
                onPressed: () {
                  // if (_eventController.text.isEmpty) return;
                  // setState(() {
                  //   if (_events[_controller.selectedDay] != null) {
                  //     _events[_controller.selectedDay]
                  //         .add(_eventController.text);
                  //   } else {
                  //     _events[_controller.selectedDay] = [
                  //       _eventController.text
                  //     ];
                  //   }
                  // });
                }),
          ]),
    );
  }
}

//   @override
// Widget build(BuildContext context) {
// return Scaffold(body: new LayoutBuilder(
//     builder: (BuildContext context, BoxConstraints viewportConstraints) {
//   return SingleChildScrollView(
//       child: ConstrainedBox(
//           constraints:
//               BoxConstraints(minHeight: viewportConstraints.maxHeight),
//           child: Container(color: Colors.brown)));
// }));
// }

// }
*/