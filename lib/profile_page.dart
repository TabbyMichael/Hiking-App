import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Column(
        children: [
          // Display profile picture and bio
          const CircleAvatar(
              radius: 50, backgroundImage: AssetImage('assets/avatar.png')),
          const SizedBox(height: 10),
          const Text('John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text('Hiking Enthusiast',
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          const Divider(),
          // Display personal hike feed
          Expanded(
            child: ListView(
              children: const [
                // List of personal hikes
                ListTile(
                    title: Text('Hike 1: Yosemite'),
                    subtitle: Text('Posted on Sept 10, 2024')),
                ListTile(
                    title: Text('Hike 2: Zion'),
                    subtitle: Text('Posted on Sept 5, 2024')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
