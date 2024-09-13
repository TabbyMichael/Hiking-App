import 'package:flutter/material.dart';

class FindTrailsScreen extends StatelessWidget {
  const FindTrailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Trails'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text('Find Trails Screen'),
      ),
    );
  }
}
