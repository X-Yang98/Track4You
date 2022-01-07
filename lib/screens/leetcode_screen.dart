import 'package:flutter/material.dart';

class LeetcodeScreen extends StatelessWidget {
  const LeetcodeScreen({Key? key}) : super(key: key);
  static const String id = 'leetcode_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leetcode'),
      ),
      body: Container(
        child: Text('Page content goes here'),
      ),
    );
  }
}
