import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'leetPair.dart';

class LeetCodeBar extends StatelessWidget {
  final List<LeetPair> data;

  LeetCodeBar(this.data);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<LeetPair, String>> series = [
      charts.Series(
        id: "Leet",
        data: data,
        domainFn: (LeetPair pair, _) => pair.difficulty,
        measureFn: (LeetPair pair, _) => pair.count,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];

    return Container(
        height: 400,
        padding: EdgeInsets.all(20),
        child: charts.BarChart(
          series,
          animate: true,
        ));
  }
}
