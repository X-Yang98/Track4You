// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_finance_screen.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({Key? key}) : super(key: key);

  static const String id = 'health_screen';

  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  final TextEditingController minsController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  User? loggiedInUser = FirebaseAuth.instance.currentUser;

  void getGoals() async {
    final goals = await _firestore.collection('financeTasks').get();
    for (var goal in goals.docs) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Health'),
        backgroundColor: Colors.grey[850],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.tealAccent,
        child: Icon(
          Icons.add,
          color: Colors.grey[900],
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          children: const <Widget>[
            HealthGoalStream(),
            TextField(
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class HealthGoalStream extends StatelessWidget {
  const HealthGoalStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<QuerySnapshot>(
    //   stream: _firestore.collection('messages').snapshots(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return Center(
    //         child: CircularProgressIndicator(
    //           backgroundColor: Colors.lightBlueAccent,
    //         ),
    //       );
    //     }
    //     List<TargetBubble> targetsBubbles = [];
    //     final targets = snapshot.data!.docs
    //         .reversed; // reverse order of list --> new message at bottom of list
    //
    //     for (var target in targets) {
    //       final goal = target['goal'];
    //       final current = target['current'];
    //       final date = target['date'];
    //
    //       final targetBubble = TargetBubble(
    //         goal: goal,
    //         current: current,
    //         date: date,
    //       );
    //       targetsBubbles.add(targetBubble);
    //     }
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        children: //targets,
            [
          TargetBubble(
            name: 'Total minutes',
            goal: '1000',
            current: '600',
            date: '21-1-22',
          ),
        ],
      ),
    );
    //   },
    // );
  }
}

class TargetBubble extends StatelessWidget {
  final String name;
  final String goal;
  final String current;
  final String date;
  final double progress;
  final String percent;

  TargetBubble(
      {required this.name,
      required this.goal,
      required this.current,
      required this.date,
      Key? key})
      : progress = double.parse(current) / double.parse(goal),
        percent = (double.parse(current) / double.parse(goal) * 100)
            .toStringAsFixed(2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              animation: true,
              percent: progress,
              center: Text(
                "$percent%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.tealAccent,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Goal Amount: $goal',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Current Amount: $current',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Date: $date',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
