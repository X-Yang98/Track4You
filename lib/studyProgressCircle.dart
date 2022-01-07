import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StudyProgressCircle extends StatelessWidget {
  var progress;

  StudyProgressCircle(this.progress);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      color: Color.fromRGBO(200, 200, 200, 0.0),
      child: CircularPercentIndicator(
        header: Container(
            margin: EdgeInsets.all(10),
            child: Text('Tasks Completed',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white))),
        animationDuration: 2000,
        radius: 200.0,
        lineWidth: 13.0,
        animation: true,
        percent: progress,
        backgroundColor: Colors.white,
        center: Text(
          (progress * 100).toStringAsPrecision(3) + '%',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: Color.fromRGBO(0, 153, 204, 0.7),
      ),
    );
  }
}
