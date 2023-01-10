import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/grid_cell.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
      crossAxisCount: 7,
      children: List.generate(365, (index) {
        DateTime startDate = DateTime(DateTime.now().year, 1, 1);
        final targetDate = startDate.add(Duration(days: index));

        return Center(child: GridCell(targetDate));
      }),
    ));
  }
}
