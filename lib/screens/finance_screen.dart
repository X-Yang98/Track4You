import 'package:flutter/material.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  static const String id = 'finance_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Finances'),
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        child: Text('Page content goes here'),
      ),
    );
  }
}
