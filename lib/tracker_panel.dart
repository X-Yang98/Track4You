import 'package:flutter/material.dart';

class TrackerPanel extends StatelessWidget {
  Function navigation;
  String category = "";
  final subtitleMap = {
    "Finance": [
      "Track your finances.",
      Icon(Icons.attach_money),
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

  TrackerPanel(this.category, this.navigation);

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
              title: Text(
                category,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                subtitleMap[category]![0] as String,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('VIEW',
                      style: TextStyle(color: Color(0xFFFFFFFF))),
                  onPressed: () => navigation(category),
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
