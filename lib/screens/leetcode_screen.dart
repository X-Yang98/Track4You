import 'package:flutter/material.dart';

class LeetcodeScreen extends StatelessWidget {
  const LeetcodeScreen({Key? key}) : super(key: key);
  static const String id = 'leetcode_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Leetcode'),
      ),
      body: Container(
        child: Text('Page content goes here'),
      ),
    );
  }
}
