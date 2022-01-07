import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track_4_you/tracker_panel.dart';

import 'finance_screen.dart';
import 'health_screen.dart';
import 'leetcode_screen.dart';
import 'studies_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const String id = 'home_screen';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser = FirebaseAuth.instance.currentUser;

  void navigateTo(String screenId) {
    if (screenId == 'Finance') {
      Navigator.pushNamed(context, FinanceScreen.id);
    } else if (screenId == 'Health') {
      Navigator.pushNamed(context, HealthScreen.id);
    } else if (screenId == 'Studies') {
      Navigator.pushNamed(context, StudiesScreen.id);
    } else if (screenId == 'Leetcode') {
      Navigator.pushNamed(context, LeetcodeScreen.id);
    } else {
      Navigator.pushNamed(context, MyHomePage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    var displayName =
        loggedInUser!.displayName; // retrieve loggedInUser.displayName here
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Track4U Home'),
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              child: Text('Welcome back, \n' + displayName!,
                  style: TextStyle(fontSize: 28, color: Colors.white)),
            ),
            TrackerPanel('Finance', navigateTo),
            TrackerPanel('Studies', navigateTo),
            TrackerPanel('Health', navigateTo),
            TrackerPanel('Leetcode', navigateTo),
          ],
        ),
      ),
    );
  }
}
