import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LeetCodeChart extends StatelessWidget {
  var progress;

  LeetCodeChart(this.progress);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      color: Color.fromRGBO(200, 200, 200, 0.0),
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width - 50,
        animation: true,
        lineHeight: 20.0,
        animationDuration: 2000,
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Colors.greenAccent,
        percent: progress,
        backgroundColor: Colors.white,
        center: Text(
          (progress * 100).toStringAsPrecision(3) + '%',
          style: (progress > 60
              ? TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white)
              : TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.black87)),
        ),
        //progressColor: Color.fromRGBO(0, 153, 204, 0.7),
      ),
    );
  }
}
