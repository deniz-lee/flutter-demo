import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/constants.dart';
import 'package:flutter_demo/model/event.dart';
import 'package:flutter_demo/plugin/GoogleSignIn-macOS/google_sign_in_macos.dart';
import 'package:flutter_demo/tools/extensions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:intl/intl.dart';

enum ProviderState { none, loading, done }

class CalendarProvider extends ChangeNotifier {
  GoogleSignIn? _googleSignIn;
  GoogleSignInAccount? _googleAccount;
  CalendarApi? _calendarApi;
  CalendarList? _calendarList;
  late Map<String, List<EventModel>?> _events = {};
  ProviderState _state = ProviderState.none;

  Map<String, List<EventModel>?> get events => _events;

  ProviderState get state => _state;

  CalendarProvider(BuildContext context);

  Future<GoogleSignInAccount?> getGoogleSignInAccount() async {
    _googleSignIn ??= GoogleSignIn(
      scopes: <String>[CalendarApi.calendarReadonlyScope],
      clientId: googleClientId_,
    );
    GoogleSignInMacOS.registerWith();
    if (kDebugMode) {
      print("[CalendarProvider] getGoogleSignInAccount: $googleClientId_");
    }
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
    if (kDebugMode) {
      print("[CalendarProvider] eventsForCalendarId: $id");
    }
    Events? events = await _calendarApi?.events.list(id);
    return events?.items ?? [];
  }

  update() {
    _state = ProviderState.loading;
    notifyListeners();

    if (useDummyDataSource_) {
      updateWithDummyData();
      return;
    }
    if (_googleAccount == null) {
      Future<GoogleSignInAccount?> account = getGoogleSignInAccount();
      account.then((GoogleSignInAccount? account) {
        _googleAccount = account;
        update();
      }).catchError((error) {
        if (kDebugMode) {
          print(error);
        }
      });
      return;
    }
    if (_calendarApi == null) {
      Future<CalendarApi> calendarApi = getCalendarApi();
      calendarApi.then((CalendarApi calendarApi) {
        _calendarApi = calendarApi;
        update();
      }).catchError((error) {
        if (kDebugMode) {
          print(error);
        }
      });
      return;
    }
    if (_calendarList == null) {
      Future<CalendarList?> calendarList = getCalenderList(_calendarApi!);
      calendarList.then((CalendarList? calendarList) {
        _calendarList = calendarList;
        update();
      }).catchError((error) {
        if (kDebugMode) {
          print(error);
        }
      });
      return;
    }
    collectAllEvents(_calendarList).then((List<EventModel> events) {
      _events = reorderCalendarEventsByDateTime(events);
      _state = ProviderState.done;
      notifyListeners();
    });
  }

  Future<List<EventModel>> collectAllEvents(CalendarList? calendarList) async {
    List<EventModel> models = [];
    List<CalendarListEntry> calendars = _calendarList?.items ?? [];
    for (int i = 0; i < calendars.length; i++) {
      CalendarListEntry? entry = calendars[i];
      String? calenderId = entry.id;
      List<Event>? events = await eventsForCalendarId(calenderId);

      for (Event e in events) {
        EventModel model = EventModel(
            event: e,
            calendarId: calenderId,
            colorType: CalendarColorType.values[i]);
        model.parseToKST();
        models.add(model);
      }
    }
    return models;
  }

  Map<String, List<EventModel>?> reorderCalendarEventsByDateTime(
      List<EventModel> events) {
    Map<String, List<EventModel>?> result = {};
    for (EventModel model in events) {
      DateTime? start = model.event.start?.dateTime ?? model.event.start?.date;
      if (start?.timeZoneName.compareTo("KST") != 0) {
        start = start?.toKST();
      }
      if (start == null) continue;

      String formattedDate = DateFormat('yyyy-MM-dd').format(start);
      List<EventModel>? events = result[formattedDate];
      if (events == null) {
        result[formattedDate] = [];
      }
      result[formattedDate]?.add(model);
    }
    return result;
  }
}

extension DummyProvider on CalendarProvider {
  updateWithDummyData() {
    Future<List<EventModel>>? calendarEvents = dummyEventsForCalendarId();
    calendarEvents.then((List<EventModel> events) {
      _events = reorderCalendarEventsByDateTime(events);
      _state = ProviderState.done;
      notifyListeners();
    });
  }

  Future<List<EventModel>> dummyEventsForCalendarId() async {
    return [
      EventModel(
          event: Event(
              start: EventDateTime(
                date: DateTime.parse('2023-01-02 01:00:00'),
              ),
              summary: "event1 allDay"),
          calendarId: "dummy",
          colorType: CalendarColorType.green),
      EventModel(
          event: Event(
              start: EventDateTime(
                dateTime: DateTime.parse('2023-01-03 01:00:00'),
              ),
              end: EventDateTime(
                dateTime: DateTime.parse('2023-01-03 02:00:00'),
              ),
              summary: "event2 1h"),
          calendarId: "dummy",
          colorType: CalendarColorType.orange),
      EventModel(
          event: Event(
              start: EventDateTime(
                dateTime: DateTime.parse('2023-01-25 16:20:00'),
              ),
              end: EventDateTime(
                dateTime: DateTime.parse('2023-01-25 18:00:00'),
              ),
              summary: "event3 2h"),
          calendarId: "dummy",
          colorType: CalendarColorType.blue),
      EventModel(
          event: Event(
              start: EventDateTime(
                dateTime: DateTime.parse('2023-01-25 12:30:00'),
              ),
              end: EventDateTime(
                dateTime: DateTime.parse('2023-01-25 15:45:00'),
              ),
              summary: "event4 3h"),
          calendarId: "dummy",
          colorType: CalendarColorType.yellow),
      EventModel(
          event: Event(
              start: EventDateTime(
                dateTime: DateTime.parse('2023-02-20 16:00:00'),
              ),
              end: EventDateTime(
                dateTime: DateTime.parse('2023-02-20 17:00:00'),
              ),
              summary: "event5 1h"),
          calendarId: "dummy",
          colorType: CalendarColorType.red),
    ];
  }
}

extension LoadingDialogProvider on CalendarProvider {
  void onLoadingDialog(BuildContext context, bool show) {
    if (show) {
      showDialog(
          useRootNavigator: false,
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 15),
                    Text('Loading...')
                  ],
                ),
              ),
            );
          });
      return;
    } else {
      Navigator.of(context).pop();
      _state = ProviderState.none;
    }
  }
}
