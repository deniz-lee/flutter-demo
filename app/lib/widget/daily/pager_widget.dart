import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/daily/scroll_widget.dart';

class PagerWidget extends StatefulWidget {
  const PagerWidget({super.key});

  @override
  State<PagerWidget> createState() => _PagerWidgetState();
}

class _PagerWidgetState extends State<PagerWidget> {
  late PageController _controller;

  @override
  void initState() {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(now.year, 1, 1, 0);
    int inDays = now.difference(startDate).inDays;
    _controller = PageController(initialPage: inDays);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime(2023, 1, 1, 0);
    return PageView.builder(
        controller: _controller,
        itemCount: 365,
        itemBuilder: (BuildContext context, int index) {
          final targetDate = startDate.add(Duration(days: index));
          return ScrollWidget(targetDate);
        });
  }
}
