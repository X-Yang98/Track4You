import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:track_4_you/leetCodeChart.dart';
import 'package:track_4_you/studyProgressCircle.dart';
import 'package:track_4_you/studyTaskBox.dart';

class Leetcode extends StatefulWidget {
  static const String id = 'leetcode_screen';
  State<StatefulWidget> createState() {
    return LeetcodeState();
  }
}

class LeetcodeState extends State<Leetcode> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser = FirebaseAuth.instance.currentUser;
  List leetcodeTasks = [];
  final formKey = GlobalKey<FormState>();

  completeTask(doc) {
    print('completed:' + doc.id);
    db.collection('leetcode').doc(doc.id).update({'completed': true});
    setState(() {
      leetcodeTasks.clear();
    });
  }

  fo(String amount) {
    var uid = loggedInUser!.uid;
    db
        .collection('studyTasks')
        .add({
          'uid': uid, // !!!! user ID for firebase querying
          'easy': 0,
          'medium': 0,
          'hard': 0,
          'completed': 0,
          'target': amount,
        })
        .then((value) => print("task added"))
        .catchError((error) => print("Failed to add task: $error"));
    setState(() {
      leetcodeTasks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var uid = loggedInUser!.uid;
    print('this is the uid: ' + uid);
    CollectionReference leetcodeRef = db.collection('leetcode');
    leetcodeRef
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (leetcodeTasks.isEmpty) {
        setState(() {
          leetcodeTasks = querySnapshot.docs;
        });
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Studies'),
        backgroundColor: Colors.grey[850],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            LeetCodeChart(calculateProgress()),
            ...studyTasks.map((doc) {
              return StudyTaskBox(doc, completeTask);
            }).toList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addStudyTask(context),
        backgroundColor: Color.fromRGBO(0, 153, 204, 0.7),
        child: const Icon(Icons.post_add),
      ),
    );
  }

  addStudyTask(BuildContext context) {
    TextEditingController tempTaskNameController = TextEditingController();
    TextEditingController tempTaskTypeController = TextEditingController();
    TextEditingController tempModuleController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Add new Study Task'),
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: tempTaskNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Task Name',
                      ),
                    ),
                    TextFormField(
                      controller: tempTaskTypeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Task Type',
                      ),
                    ),
                    TextFormField(
                      controller: tempModuleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Module',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: Text("Add Task!"),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState?.save();
                      fo(
                          tempTaskNameController.text,
                          tempTaskTypeController.text,
                          tempModuleController.text);
                      Navigator.pop(context);
                    }
                  })
            ],
          );
        });
  }

  double calculateProgress() {
    var counter = 0;
    for (QueryDocumentSnapshot doc in studyTasks) {
      if (doc['completed']) {
        counter++;
      }
    }
    double doubly = counter / studyTasks.length;

    if (doubly.isNaN) {
      return 0;
    }

    return doubly;
  }
}
