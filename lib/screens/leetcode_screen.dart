import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:track_4_you/leetCodeBar.dart';
import 'package:track_4_you/leetCodeChart.dart';
import 'package:track_4_you/leetPair.dart';

import 'add_leetcode_screen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class LeetcodeScreen extends StatefulWidget {
  const LeetcodeScreen({Key? key}) : super(key: key);

  static const String id = 'leetcode_screen';

  State<StatefulWidget> createState() {
    return LeetcodeState();
  }
}

class LeetcodeState extends State<LeetcodeScreen> {
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
        title: Text('Leetcode'),
        backgroundColor: Colors.grey[850],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddLeetcodeScreen.id);
        },
        backgroundColor: Colors.purpleAccent,
        child: Icon(
          Icons.add,
          color: Colors.grey[900],
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: LeetcodeGoalStream(),
      ),
    );
  }
}

class LeetcodeGoalStream extends StatelessWidget {
  const LeetcodeGoalStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('financeTasks')
          .where('uid', isEqualTo: loggedInUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        List<LeetPair> data = [];
        final targets = snapshot.data!.docs
            .reversed; // reverse order of list --> new message at bottom of list

        for (var target in targets) {
          final easy = target['easy'];
          final medium = target['medium'];
          final hard = target['hard'];

          final target1 = LeetPair(
            difficulty: 'easy',
            count: int.parse(easy),
          );
          final target2 = LeetPair(
            difficulty: 'medium',
            count: int.parse(medium),
          );
          final target3 = LeetPair(
            difficulty: 'hard',
            count: int.parse(hard),
          );
          data.add(target1);
          data.add(target2);
          data.add(target3);
        }
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(12.0),
              alignment: Alignment.center,
              child: Text(
                'No. of questions',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.all(12.0),
              child: LeetCodeBar(data),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.all(12.0),
              alignment: Alignment.center,
              child: Text(
                'Completed (out of 10)',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            LeetCodeChart(
              ((data[0].count + data[1].count + data[2].count) / 10),
            )
          ],
        );
      },
    );
  }
}
