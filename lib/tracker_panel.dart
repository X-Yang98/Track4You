import 'package:flutter/material.dart';

class TrackerPanel extends StatelessWidget {
  String category = "";
  final subtitleMap = {
    "Finance": [
      "Track your finances.",
      Icon(Icons.money),
      Color.fromRGBO(255, 204, 102, 0.7)
    ],
    "Studies": [
      "Study harder.",
      Icon(Icons.school),
      Color.fromRGBO(0, 153, 204, 0.7)
    ],
    "Health": [
      "Health over wealth.",
      Icon(Icons.health_and_safety),
      Color.fromRGBO(0, 255, 204, 0.7)
    ],
    "Leetcode": [
      "while(true){code();}",
      Icon(Icons.desktop_mac),
      Color.fromRGBO(153, 0, 255, 0.7)
    ],
  };

  TrackerPanel(String category) {
    this.category = category;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: subtitleMap[category]![2] as Color,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: subtitleMap[category]![1] as Widget,
              title: Text(category),
              subtitle: Text(subtitleMap[category]![0] as String),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('STATS',
                      style: TextStyle(color: Color(0xFFFFFFFF))),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('ADD TASK',
                      style: TextStyle(color: Color(0xFFFFFFFF))),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}