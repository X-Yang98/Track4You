import 'package:flutter/material.dart';

class LeetcodeScreen extends StatefulWidget {
  static const String id = 'leetcode_screen';
  State<StatefulWidget> createState() {
    return LeetcodeState();
  }
}

class LeetcodeState extends State<LeetcodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Studies'),
        backgroundColor: Colors.grey[850],
      ),
      body: Container(),
    );
  }
}
