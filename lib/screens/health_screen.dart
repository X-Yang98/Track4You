// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'add_health_screen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class HealthScreen extends StatefulWidget {
  const HealthScreen({Key? key}) : super(key: key);

  static const String id = 'health_screen';

  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final User? user = _auth.currentUser;

    try {
      loggedInUser = user;
      print(loggedInUser?.email);
    } catch (e) {
      print(e);
    }
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
        onPressed: () {
          Navigator.pushNamed(context, AddHealthScreen.id);
        },
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
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('healthTasks')
            .where('uid', isEqualTo: loggedInUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.tealAccent,
              ),
            );
          }
          List<HealthBubble> healthBubbles = [];
          final healths = snapshot.data!.docs
              .reversed; // reverse order of list --> new message at bottom of list

          for (var health in healths) {
            final activity = health['activity'];
            final targetHours = health['targetHours'];
            final currentHours = health['targetHours'];
            final docId = health.reference.id;

            final healthBubble = HealthBubble(
              activity: activity,
              targetHours: targetHours,
              currentHours: currentHours,
              docId: docId,
            );
            healthBubbles.add(healthBubble);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              children: //targets,
                  healthBubbles,
            ),
          );
        });
  }
}

class HealthBubble extends StatelessWidget {
  final String activity;
  final String targetHours;
  final String currentHours;
  final double progress;
  final String percent;
  final String docId;
  final formKey = GlobalKey<FormState>();
  final TextEditingController addController = TextEditingController();

  HealthBubble(
      {required this.activity,
      required this.targetHours,
      required this.currentHours,
      required this.docId,
      Key? key})
      : progress = double.parse(currentHours) / double.parse(targetHours),
        percent = (double.parse(currentHours) / double.parse(targetHours) * 100)
            .toStringAsFixed(0),
        super(key: key);

  fo(
    String addOn,
  ) {
    var uid = loggedInUser!.uid;
    _firestore.collection('healthTasks').doc(docId).update({
      'current':
          (double.parse(currentHours) + double.parse(addOn)).toStringAsFixed(0)
    }).catchError((e) => print(e));
  }

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
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: LinearPercentIndicator(
                    width: 140.0,
                    lineHeight: 14.0,
                    percent: progress >= 1 ? 1 : progress,
                    center: Text(
                      progress >= 1 ? "Done" : "$percent%",
                      style: new TextStyle(fontSize: 12.0),
                    ),
                    trailing: Icon(Icons.mood),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),
                ),
                Text(
                  activity,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Target Hours: $targetHours',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Current Hours: $currentHours',
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
