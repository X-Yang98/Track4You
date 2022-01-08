// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'add_leetcode_screen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class LeetcodeScreen extends StatefulWidget {
  const LeetcodeScreen({Key? key}) : super(key: key);

  static const String id = 'leetcode_screen';

  @override
  _LeetcodeScreenState createState() => _LeetcodeScreenState();
}

class _LeetcodeScreenState extends State<LeetcodeScreen> {
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
    } catch (e) {}
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
        backgroundColor: Colors.orangeAccent,
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
            LeetcodeGoalStream(),
          ],
        ),
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
          .collection('leetcode')
          .where('uid', isEqualTo: loggedInUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        List<TargetBubble> targetsBubbles = [];
        final targets = snapshot.data!.docs
            .reversed; // reverse order of list --> new message at bottom of list

        for (var tar in targets) {
          final completed = tar['completed'];
          final target = tar['target'];
          final difficulty = tar['difficulty'];
          final docId = tar.reference.id;

          final targetBubble = TargetBubble(
            completed: completed,
            target: target,
            difficulty: difficulty,
            docId: docId,
          );
          targetsBubbles.add(targetBubble);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            children: //targets,
                targetsBubbles,
          ),
        );
      },
    );
  }
}

class TargetBubble extends StatelessWidget {
  final String completed;
  final String target;
  final String difficulty;
  final double progress;
  final String percent;
  final String docId;
  final formKey = GlobalKey<FormState>();
  final TextEditingController addController = TextEditingController();

  TargetBubble(
      {required this.completed,
      required this.target,
      required this.difficulty,
      required this.docId,
      Key? key})
      : progress = double.parse(completed) / double.parse(target),
        percent = (double.parse(completed) / double.parse(target) * 100)
            .toStringAsFixed(0),
        super(key: key);

  fo(
    String addOn,
  ) {
    var uid = loggedInUser!.uid;
    _firestore.collection('leetcode').doc(docId).update({
      'completed':
          (double.parse(completed) + double.parse(addOn)).toStringAsFixed(0)
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
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              animation: true,
              percent: progress >= 1 ? 1 : progress,
              center: Text(
                progress >= 1 ? "Completed" : "$percent%",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: progress >= 1 ? 17.0 : 20.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor:
                  progress >= 1 ? Colors.greenAccent : Colors.deepPurple,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Target: $target',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Completed: $completed',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Difficulty: $difficulty',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                TextButton(
                    child: Text(
                      'Add new completions',
                    ),
                    onPressed: () => updateLeetcodeTask(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  updateLeetcodeTask(BuildContext context) {
    TextEditingController addController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Add new completions'),
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: addController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Add to current completions',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: Text("Add completions"),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState?.save();
                      fo(
                        addController.text,
                      );
                      Navigator.pop(context);
                    }
                  })
            ],
          );
        });
  }
}
