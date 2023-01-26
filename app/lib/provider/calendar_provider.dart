import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/constants.dart' as Constants;
import 'package:flutter_demo/model/event.dart' as Dao;
import 'package:flutter_demo/plugin/GoogleSignIn-macOS/google_sign_in_macos.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:intl/intl.dart';

class CalendarProvider extends ChangeNotifier {
  GoogleSignIn? _googleSignIn;
  GoogleSignInAccount? _googleAccount;
  CalendarApi? _calendarApi;
  CalendarList? _calendarList;
  late Map<String, List<Dao.Event>?> _events = {};

  Map<String, List<Dao.Event>?> get events => _events;

  CalendarProvider(BuildContext context);

  Future<GoogleSignInAccount?> getGoogleSignInAccount() async {
    _googleSignIn ??= GoogleSignIn(
      scopes: <String>[CalendarApi.calendarReadonlyScope],
      clientId: Constants.GOOGLE_API_CLIENT_ID,
    );
    GoogleSignInMacOS.registerWith();
    final GoogleSignInAccount? googleUser = await _googleSignIn?.signIn();
    return googleUser;
  }

  Future<CalendarApi> getCalendarApi() async {
    final AuthClient? authClient = await _googleSignIn?.authenticatedClient();
    if (authClient == null) {
      throw Exception('authenticatedClient failed.');
    }
    return CalendarApi(authClient);
  }

  Future<CalendarList> getCalenderList(CalendarApi api) async {
    CalendarList calendarList = await api.calendarList.list();
    return calendarList;
  }

  Future<List<Event>> eventsForCalendarId(String? id) async {
    print("[CalenderProvider] eventsForCalendarId");
    if (id == null || id.isEmpty) {
      return [];
    }
    Events? events = await _calendarApi?.events.list(id);
    return events?.items ?? [];
  }

  update() {
    if (Constants.CALENDAR_DUMMY_DATASOURCE) {
      updateWithDummyData();
      return;
    }
    if (_googleAccount == null) {
      Future<GoogleSignInAccount?> account = getGoogleSignInAccount();
      account.then((GoogleSignInAccount? account) {
        _googleAccount = account;
        update();
      }).catchError((error) {
        print(error);
      });
      return;
    }
    if (_calendarApi == null) {
      Future<CalendarApi> calendarApi = getCalendarApi();
      calendarApi.then((CalendarApi calendarApi) {
        _calendarApi = calendarApi;
        update();
      }).catchError((error) {
        print(error);
      });
      return;
    }
    if (_calendarList == null) {
      Future<CalendarList?> calendarList = getCalenderList(_calendarApi!);
      calendarList.then((CalendarList? calendarList) {
        _calendarList = calendarList;
        update();
      }).catchError((error) {
        print(error);
      });
      return;
    }
    collectAllEvents(_calendarList).then((List<Dao.Event> events) {
      _events = reorderCalendarEventsByDateTime(events);
      for (Dao.Event dao in events) {
        print("${dao.event.summary.toString()}, [${dao.calendarId}");
      }
      notifyListeners();
    });
  }

  Future<List<Dao.Event>> collectAllEvents(CalendarList? calendarList) async {
    List<Dao.Event> allEvents = [];
    for (CalendarListEntry entry in _calendarList?.items ?? []) {
      String? calenderId = entry.id;
      List<Event>? events = await eventsForCalendarId(calenderId);

      for (Event e in events) {
        Dao.Event dao = Dao.Event(event: e, calendarId: calenderId);
        allEvents.add(dao);
      }
    }
    return allEvents;
  }

  Map<String, List<Dao.Event>?> reorderCalendarEventsByDateTime(
      List<Dao.Event> events) {
    Map<String, List<Dao.Event>?> result = {};
    for (Dao.Event dao in events) {
      DateTime? startTime = dao.event.start?.dateTime ?? dao.event.start?.date;
      if (startTime == null) continue;

      String formattedDate = DateFormat('yyyy-MM-dd').format(startTime);
      List<Dao.Event>? events = result[formattedDate];
      if (events == null) {
        result[formattedDate] = [];
      }
      result[formattedDate]?.add(dao);
    }
    return result;
  }
}

extension DummyProvider on CalendarProvider {
  updateWithDummyData() {
    Future<List<Dao.Event>>? calendarEvents = dummyEventsForCalendarId();
    calendarEvents?.then((List<Dao.Event> events) {
      _events = reorderCalendarEventsByDateTime(events);
      notifyListeners();
    });
  }

  Future<List<Dao.Event>> dummyEventsForCalendarId() async {
    return [
      Dao.Event(
          event: Event(
              start: EventDateTime(
                date: DateTime.parse('2023-01-02 01:00:00'),
              ),
              summary: "event1 allDay"),
          calendarId: "dummy"),
      Dao.Event(
          event: Event(
              start: EventDateTime(
                dateTime: DateTime.parse('2023-01-03 01:00:00'),
              ),
              end: EventDateTime(
                dateTime: DateTime.parse('2023-01-03 02:00:00'),
              ),
              summary: "event2 1h"),
          calendarId: "dummy"),
      Dao.Event(
          event: Event(
              start: EventDateTime(
                dateTime: DateTime.parse('2023-01-25 16:20:00'),
              ),
              end: EventDateTime(
                dateTime: DateTime.parse('2023-01-25 18:00:00'),
              ),
              summary: "event3 2h"),
          calendarId: "dummy"),
      Dao.Event(
          event: Event(
              start: EventDateTime(
                dateTime: DateTime.parse('2023-01-25 12:30:00'),
              ),
              end: EventDateTime(
                dateTime: DateTime.parse('2023-01-25 15:45:00'),
              ),
              summary: "event4 3h"),
          calendarId: "dummy"),
      Dao.Event(
          event: Event(
              start: EventDateTime(
                dateTime: DateTime.parse('2023-02-20 16:00:00'),
              ),
              end: EventDateTime(
                dateTime: DateTime.parse('2023-02-20 17:00:00'),
              ),
              summary: "event5 1h"),
          calendarId: "dummy"),
    ];
  }
}
