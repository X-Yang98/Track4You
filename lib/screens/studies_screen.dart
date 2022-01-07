import 'package:flutter/material.dart';

class StudiesScreen extends StatelessWidget {
  const StudiesScreen({Key? key}) : super(key: key);
  static const String id = 'studies_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Studies'),
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        child: Text('Page content goes here'),
      ),
    );
  }
}
