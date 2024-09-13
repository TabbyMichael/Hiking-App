// home_page.dart

import 'package:flutter/material.dart';
import 'package:hiking_app/Homepage/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String username =
        "User"; // Replace with actual username retrieval logic
    final List<Hike> hikes = [
      Hike("Trail 1", "This is a beautiful hike near...", "assets/trail 1.jpg"),
      Hike("Trail 2", "Another amazing hiking experience...",
          "assets/trail 2.jpg"),
      Hike("Trail 3", "Discover the serene beauty of this hidden gem.",
          "assets/trail 3.jpg"),
      Hike("Trail 4", "A challenging hike with breathtaking views.",
          "assets/trail 4.jpg"),
      Hike("Trail 5", "An easy trail perfect for beginners and families.",
          "assets/trail 5.jpg"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hiking Adventures",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeMessage(username),
            _buildQuickActions(context),
            _buildFeaturedHikes(hikes),
            _buildWeatherWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(
                  context, '/home'); // Replace with actual route
              break;
            case 1:
              Navigator.pushNamed(context, '/map'); // Replace with actual route
              break;
            case 2:
              Navigator.pushNamed(
                  context, '/settings'); // Replace with actual route
              break;
          }
        },
      ),
    );
  }

  Widget _buildWelcomeMessage(String username) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "Welcome Back, $username",
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(Icons.hiking, "New Hike", () {
            Navigator.pushNamed(context, '/hike'); // Replace with actual route
          }),
          _buildActionButton(Icons.map, "Find Trails", () {
            Navigator.pushNamed(
                context, '/findTrails'); // Replace with actual route
          }),
          _buildActionButton(Icons.person, "Profile", () {
            Navigator.pushNamed(
                context, '/profile'); // Replace with actual route
          }),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 32),
          onPressed: onPressed,
        ),
        Text(label),
      ],
    );
  }

  Widget _buildFeaturedHikes(List<Hike> hikes) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Featured Hikes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: hikes.length,
            itemBuilder: (context, index) {
              final hike = hikes[index];
              return _buildHikeCard(
                  hike.name, hike.description, hike.imagePath);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHikeCard(String hikeName, String description, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child:
              Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.cover),
        ),
        title:
            Text(hikeName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        onTap: () {
          // Navigate to hike details
        },
      ),
    );
  }

  Future<String> fetchWeather() async {
    // Replace with actual API call to get weather data
    return "75°F, Sunny";
  }

  Widget _buildWeatherWidget() {
    return FutureBuilder<String>(
      future: fetchWeather(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 10),
                Text("Loading weather..."),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Failed to load weather"),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.wb_sunny, size: 32),
                const SizedBox(width: 10),
                Text(snapshot.data ?? "N/A"),
              ],
            ),
          );
        }
      },
    );
  }
}

class Hike {
  final String name;
  final String description;
  final String imagePath;

  Hike(this.name, this.description, this.imagePath);
}
