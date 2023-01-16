import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/constants.dart' as Constants;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';

class CalendarProvider extends ChangeNotifier {
  GoogleSignIn? _googleSignIn;
  GoogleSignInAccount? _googleAccount;
  CalendarApi? _calendarApi;
  CalendarList? _calendarList;

  CalendarList? get calendarList => _calendarList;

  CalendarProvider(BuildContext context);

  Future<GoogleSignInAccount?> getGoogleSignInAccount() async {
    _googleSignIn ??= GoogleSignIn(
      scopes: <String>[CalendarApi.calendarReadonlyScope],
      clientId: Constants.GOOGLE_API_CLIENT_ID,
    );
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
    if (id == null || id.isEmpty) {
      return [];
    }
    return [
      Event(
          start: EventDateTime(
            date: DateTime.parse('2023-01-02 01:00:00'),
          ),
          summary: "event1 allDay"),
      Event(
          start: EventDateTime(
            dateTime: DateTime.parse('2023-01-03 01:00:00'),
          ),
          end: EventDateTime(
            dateTime: DateTime.parse('2023-01-03 02:00:00'),
          ),
          summary: "event2 1h"),
      Event(
          start: EventDateTime(
            dateTime: DateTime.parse('2023-01-03 16:00:00'),
          ),
          end: EventDateTime(
            dateTime: DateTime.parse('2023-01-03 18:00:00'),
          ),
          summary: "event3 2h"),
      Event(
          start: EventDateTime(
            dateTime: DateTime.parse('2023-02-20 16:00:00'),
          ),
          end: EventDateTime(
            dateTime: DateTime.parse('2023-02-20 17:00:00'),
          ),
          summary: "event4 1h"),
    ];
    // Events? events = await _calendarApi?.events.list(id);
    // return events?.items ?? [];
  }

  update() {
    // if (_googleAccount == null) {
    //   Future<GoogleSignInAccount?> account = getGoogleSignInAccount();
    //   account.then((GoogleSignInAccount? account) {
    //     _googleAccount = account;
    //     update();
    //   }).catchError((error) {
    //     print(error);
    //   });
    //   return;
    // }
    // if (_calendarApi == null) {
    //   Future<CalendarApi> calendarApi = getCalendarApi();
    //   calendarApi.then((CalendarApi calendarApi) {
    //     _calendarApi = calendarApi;
    //     update();
    //   }).catchError((error) {
    //     print(error);
    //   });
    //   return;
    // }
    _calendarList = CalendarList(items: [CalendarListEntry(id: "dummy")]);
    notifyListeners();
    // Future<CalendarList?> calendarList = getCalenderList(_calendarApi!);
    // calendarList.then((CalendarList? calendarList) {
    //   _calendarList = calendarList;
    //   notifyListeners();
    // }).catchError((error) {
    //   print(error);
    // });
  }
}
