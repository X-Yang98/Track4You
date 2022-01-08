// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'add_finance_screen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  static const String id = 'finance_screen';

  @override
  _FinanceScreenState createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
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
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Finance'),
        backgroundColor: Colors.grey[850],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddFinanceScreen.id);
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
            FinanceGoalStream(),
          ],
        ),
      ),
    );
  }
}

class FinanceGoalStream extends StatelessWidget {
  const FinanceGoalStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('financeTasks')
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

        for (var target in targets) {
          final name = target['name'];
          final goal = target['goal'];
          final current = target['current'];
          final date = target['date'];
          final docId = target.reference.id;

          final targetBubble = TargetBubble(
            name: name,
            goal: goal,
            current: current,
            date: date,
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
  final String name;
  final String goal;
  final String current;
  final String date;
  final double progress;
  final String percent;
  final String docId;
  final formKey = GlobalKey<FormState>();
  final TextEditingController addController = TextEditingController();

  TargetBubble(
      {required this.name,
      required this.goal,
      required this.current,
      required this.date,
      required this.docId,
      Key? key})
      : progress = double.parse(current) / double.parse(goal),
        percent = (double.parse(current) / double.parse(goal) * 100)
            .toStringAsFixed(0),
        super(key: key);

  fo(
    String addOn,
  ) {
    _firestore.collection('financeTasks').doc(docId).update({
      'current':
          (double.parse(current) + double.parse(addOn)).toStringAsFixed(0)
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
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor:
                  progress >= 1 ? Colors.greenAccent : Colors.orangeAccent,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Goal Amount: \$$goal',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Current Amount: \$$current',
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
                TextButton(
                    child: Text(
                      'Add current amount',
                    ),
                    onPressed: () => updateFinanceTask(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  updateFinanceTask(BuildContext context) {
    TextEditingController addController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Add to current amount'),
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
                        labelText: 'Add to current amount',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: Text("Add amount"),
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
