import 'package:flutter/material.dart';

class HikePage extends StatelessWidget {
  final String hikeName;
  final String hikeDescription;

  const HikePage(
      {super.key, required this.hikeName, required this.hikeDescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hikeName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hike details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(hikeDescription, style: const TextStyle(fontSize: 16)),
          ),
          const Divider(),
          // Weather and reviews go here
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Weather forecast: Sunny, 75°F'),
          ),
        ],
      ),
    );
  }
}
