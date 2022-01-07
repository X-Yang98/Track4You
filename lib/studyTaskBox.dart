import 'package:flutter/material.dart';

class StudyTaskBox extends StatelessWidget {
  @override
  var doc;
  Function completeTask;

  StudyTaskBox(this.doc, this.completeTask);

  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      width: double.infinity,
      child: Card(
          child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(doc['taskType'] + ": " + doc['taskName'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(doc['module'], style: TextStyle(fontStyle: FontStyle.italic)),
            Container(
                height: 70,
                alignment: Alignment.bottomCenter,
                child: doc['completed']
                    ? Text('Task Completed!')
                    : ElevatedButton(
                        onPressed: () => {completeTask(doc)},
                        child: Text('COMPLETE')))
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      )),
    ));
  }
}
