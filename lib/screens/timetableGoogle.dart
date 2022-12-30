// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis_auth/googleapis_auth.dart';
// import 'package:googleapis_auth/auth_io.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;
import 'package:flutter/widgets.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart';

class Timetable extends StatefulWidget {
  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: 'OAuth Client ID',
    scopes: <String>[
      googleAPI.CalendarApi.calendarScope,
    ],
  );

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
                    child: FutureBuilder(
                      future: getGoogleEventsData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return Container(
                            child: Stack(
                          children: [
                            Container(
                              child: SfCalendar(
                                backgroundColor: Colors.transparent,
                                headerStyle: CalendarHeaderStyle(
                                    // centerHeaderTitle: true,
                                    textAlign: TextAlign.center,
                                    textStyle: TextStyle(
                                        color: Colors.black, fontSize: 25)),
                                view: CalendarView.month,
                                initialDisplayDate: DateTime.now(),
                                dataSource:
                                    GoogleDataSource(events: snapshot.data),
                                monthViewSettings: MonthViewSettings(
                                    appointmentDisplayMode:
                                        MonthAppointmentDisplayMode
                                            .appointment),
                              ),
                            ),
                            snapshot.data == null
                                ? Container()
                                : Center(
                                    child: CircularProgressIndicator(),
                                  )
                          ],
                        ));
                      },
                    )),
              ));
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_googleSignIn.currentUser != null) {
      _googleSignIn.disconnect();
      _googleSignIn.signOut();
    }

    super.dispose();
  }

  Future<List<googleAPI.Event>> getGoogleEventsData() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleAPIClient httpClient =
        GoogleAPIClient(await googleUser.authHeaders);
    final googleAPI.CalendarApi calendarAPI = googleAPI.CalendarApi(httpClient);
    final googleAPI.Events calEvents = await calendarAPI.events.list(
      "primary",
    );
    final List<googleAPI.Event> appointments = <googleAPI.Event>[];
    if (calEvents != null && calEvents.items != null) {
      for (int i = 0; i < calEvents.items.length; i++) {
        final googleAPI.Event event = calEvents.items[i];
        if (event.start == null) {
          continue;
        }
        appointments.add(event);
      }
    }
    return appointments;
  }
}

class GoogleDataSource extends CalendarDataSource {
  GoogleDataSource({List<googleAPI.Event> events}) {
    this.appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    final googleAPI.Event event = appointments[index];
    return event.start.date ?? event.start.dateTime.toLocal();
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].start.date != null;
  }

  @override
  DateTime getEndTime(int index) {
    final googleAPI.Event event = appointments[index];
    return event.endTimeUnspecified != null && event.endTimeUnspecified
        ? (event.start.date ?? event.start.dateTime.toLocal())
        : (event.end.date != null
            ? event.end.date.add(Duration(days: -1))
            : event.end.dateTime.toLocal());
  }

  @override
  String getLocation(int index) {
    return appointments[index].location;
  }

  @override
  String getNotes(int index) {
    return appointments[index].description;
  }

  @override
  String getSubject(int index) {
    final googleAPI.Event event = appointments[index];
    return event.summary == null || event.summary.isEmpty
        ? 'No Title'
        : event.summary;
  }
}

class GoogleAPIClient extends IOClient {
  Map<String, String> _headers;

  GoogleAPIClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));
}
