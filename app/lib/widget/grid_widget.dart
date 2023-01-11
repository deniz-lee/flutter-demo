import 'package:flutter/material.dart';

import 'grid_cell.dart';

class GridWidget extends StatefulWidget {
  const GridWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GridWidgetState();
}

class GridWidgetState extends State<GridWidget> {
  late int _length;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _length = 365;
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.hasClients) {
        if (_controller.position.maxScrollExtent == _controller.offset) {
          setState(() {
            _length += 365;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          controller: _controller,
          itemCount: _length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemBuilder: (context, index) {
            DateTime startDate = DateTime(DateTime.now().year, 1, 1);
            final targetDate = startDate.add(Duration(days: index));
            return Center(child: GridCell(targetDate));
          }),
    );
  }
}
