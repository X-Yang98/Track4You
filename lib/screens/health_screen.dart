import 'package:flutter/material.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({Key? key}) : super(key: key);
  static const String id = 'health_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Health'),
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        child: Text('Page content goes here'),
      ),
    );
  }
}
