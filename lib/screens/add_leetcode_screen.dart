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
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String easy;
  late String medium;
  late String hard;
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
                        'Easy Questions:',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: (value) {
                        easy = value;
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
                        'Medium Questions:',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: (value) {
                        medium = value;
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
                        'Hard Questions:',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: (value) {
                        hard = value;
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
                  _firestore.collection('financeTasks').add(
                    {
                      'easy': easy,
                      'uid': loggedInUser!.uid,
                      'medium': medium,
                      'hard': hard,
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
