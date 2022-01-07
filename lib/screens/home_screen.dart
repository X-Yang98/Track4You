import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track_4_you/tracker_panel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const String id = 'home_screen';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  Widget build(BuildContext context) {
    var displayName = 'John Doe'; // retrieve loggedInUser.displayName here
    return Scaffold(
      appBar: AppBar(
        title: Text('Track4U Home'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              child: Text('Welcome back, \n' + displayName,
                  style: TextStyle(fontSize: 28)),
            ),
            TrackerPanel('Finance'),
            TrackerPanel('Studies'),
            TrackerPanel('Health'),
            TrackerPanel('Leetcode'),
          ],
        ),
      ),
    );
  }
}
