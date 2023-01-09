import 'package:flutter/material.dart';

class CalendarProvider extends ChangeNotifier {
  // private variables
  int _count = 0;

  // getter
  int get count => _count;

  CalendarProvider(BuildContext context);

  add() {
    _count++;
    notifyListeners();
  }

  minus() {
    _count--;
    notifyListeners();
  }
}
