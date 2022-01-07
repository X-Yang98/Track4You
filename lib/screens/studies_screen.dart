import 'package:flutter/material.dart';

class StudiesScreen extends StatelessWidget {
  const StudiesScreen({Key? key}) : super(key: key);
  static const String id = 'studies_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Studies'),
      ),
      body: Container(
        child: Text('Page content goes here'),
      ),
    );
  }
}
