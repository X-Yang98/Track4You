// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddLeetcodeScreen extends StatefulWidget {
  const AddLeetcodeScreen({Key? key}) : super(key: key);

  static const String id = 'add_leetcode_screen';

  @override
  _AddLeetcodeScreenState createState() => _AddLeetcodeScreenState();
}

class _AddLeetcodeScreenState extends State<AddLeetcodeScreen> {
  final _firestore = FirebaseFirestore.instance;
  late String target;
  late String difficulty;
  User? loggedInUser = FirebaseAuth.instance.currentUser;

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentUser();
  // }
  //
  // void getCurrentUser() {
  //   final User? user = _auth.currentUser;
  //   // if not logged in, will be null
  //   // returns a Future
  //
  //   try {
  //     loggedInUser = user;
  //     print(loggedInUser?.email);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Add Leetcode Goal'),
        backgroundColor: Colors.grey[850],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Target for the week:',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: (value) {
                        target = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type number here...',
                        fillColor: Colors.purpleAccent,
                        filled: true,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Problem difficulty:',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: (value) {
                        difficulty = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type number here...',
                        fillColor: Colors.purpleAccent,
                        filled: true,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  _firestore.collection('leetcode').add(
                    {
                      'difficulty': difficulty,
                      'uid': loggedInUser!.uid,
                      'target': target,
                      'completed': "0",
                    },
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  'FAANG',
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
