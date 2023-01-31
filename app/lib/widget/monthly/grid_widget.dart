import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/constants.dart';
import 'package:flutter_demo/model/event.dart';
import 'package:flutter_demo/provider/calendar_provider.dart';
import 'package:flutter_demo/widget/monthly/page_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'grid_cell.dart';

class GridWidget extends StatefulWidget {
  const GridWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  late int _length;
  late ScrollController _controller;
  late Size _gridCellSize;
  final DateTime _initDate = DateTime(DateTime.now().year, 1, 1);
  late DateTime _appBarDateTime = DateTime(DateTime.now().year, 1, 1);

  @override
  void initState() {
    _length = monthlyItemCount_;
    _controller = ScrollController();
    _controller.addListener(() {
      _updateAppBarDateIfNeeded();
      _addGridCellCountIfNeeded();
    });
    super.initState();
  }

  void _updateAppBarDateIfNeeded() {
    if (!_controller.hasClients) {
      return ;
    }
    if (_gridCellSize.width == 0 || _gridCellSize.height == 0 ) {
      return ;
    }
    int rowIdx = _controller.offset ~/ _gridCellSize.height;
    int days = rowIdx * 7 + 7;
    final targetDate = _initDate.add(Duration(days: days));
    if (_appBarDateTime.year != targetDate.year ||
        _appBarDateTime.month != targetDate.month) {
      setState(() {
        _appBarDateTime = DateTime(targetDate.year, targetDate.month, 1);
      });
    }
  }

  void _addGridCellCountIfNeeded() {
    if (!_controller.hasClients) {
      return ;
    }
    _updateAppBarDateIfNeeded();
    if (_controller.position.maxScrollExtent == _controller.offset) {
      setState(() {
        _length += monthlyItemCount_;
      });
    }
  }

  OnGridCellSizeChange get _didGridCellSizeChange => (Size size) {
    _gridCellSize = size;
  };

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("[GridWidget] build");
    }
    return Scaffold(
      appBar: PageAppBar(_appBarDateTime),
      body: GridView.builder(
          controller: _controller,
          itemCount: _length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemBuilder: (context, index) {
            DateTime startDate = DateTime(DateTime.now().year, 1, 1);
            final targetDate = startDate.add(Duration(days: index));
            String formattedDate = DateFormat('yyyy-MM-dd').format(targetDate);
            List<EventModel>? events =
                Provider.of<CalendarProvider>(context).events[formattedDate];
            OnGridCellSizeChange? onChange;
            if (index == 0) {
              onChange = _didGridCellSizeChange;
            }
            if (events != null) {
              return Center(child: GridCell(targetDate, events, onChange));
            }
            return Center(child: GridCell(targetDate, null, onChange));
          }),
    );
  }
}
