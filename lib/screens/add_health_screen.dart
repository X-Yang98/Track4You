// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddHealthScreen extends StatefulWidget {
  const AddHealthScreen({Key? key}) : super(key: key);

  static const String id = 'add_health_screen';

  @override
  _AddHealthScreenState createState() => _AddHealthScreenState();
}

class _AddHealthScreenState extends State<AddHealthScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String activity;
  late String targetHours;
  late String currentHours;
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
        title: Text('Add Health Goal'),
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
                        'Activity Name:',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: (value) {
                        activity = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type activity name here...',
                        fillColor: Colors.tealAccent,
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
                        'Target Hours:',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: (value) {
                        targetHours = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type target hours here...',
                        fillColor: Colors.tealAccent,
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
                        'Current Hours:',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: (value) {
                        currentHours = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type current hours here...',
                        fillColor: Colors.tealAccent,
                        filled: true,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  _firestore.collection('healthTasks').add(
                    {
                      'activity': activity,
                      'uid': loggedInUser!.uid,
                      'targetHours': targetHours,
                      'currentHours': currentHours,
                    },
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  'LEGGO',
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
