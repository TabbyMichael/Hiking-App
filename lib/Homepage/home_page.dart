import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hiking_app/API%20s/weather_alerts_api.dart';
import 'package:hiking_app/Homepage/bottom_nav_bar.dart';
import 'package:hiking_app/models/hike.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Map<String, dynamic>>>? _weatherAlertsFuture;
  Future<List<Map<String, dynamic>>>? _newsFuture;
  int _currentIndex = 0; // Initialize the currentIndex for the BottomNavBar

  @override
  void initState() {
    super.initState();
    _weatherAlertsFuture = fetchWeatherAlerts();
    _newsFuture = fetchWeatherAlerts(); // Fetch news articles
  }

  // Method to handle BottomNavBar tap
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });

    // Handle navigation based on index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/maps');
        break;
      case 2:
        Navigator.pushNamed(context, '/hike');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
          "Hiking",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _newsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final news = snapshot.data!;
                  return _buildNewsSection(news);
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
          Expanded(
            flex: 7,
            child: _buildFeaturedHikes(hikes),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        backgroundColor: Colors.brown, // Set the background color to brown
        selectedItemColor: Colors.white, // White color for the selected item
        unselectedItemColor:
            Colors.white70, // Lighter white color for unselected items
        currentIndex: _currentIndex, // Provide the current index
        onTap: _onTabTapped, // Handle tab changes
      ),
    );
  }

  Widget _buildNewsSection(List<Map<String, dynamic>> news) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            "assets/hiking 7.jpg",
            fit: BoxFit.cover,
          ),
        ),
        // Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.2),
                ],
              ),
            ),
          ),
        ),
        // Carousel Slider
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CarouselSlider.builder(
            itemCount: news.length,
            itemBuilder: (context, index, realIndex) {
              final article = news[index];
              return _buildNewsCard(
                article['title']!,
                article['description']!,
                article['urlToImage']!,
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewsCard(String title, String description, String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white.withOpacity(0.8),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedHikes(List<Hike> hikes) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Featured Hikes",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: hikes.length,
              itemBuilder: (context, index) {
                final hike = hikes[index];
                return _buildHikeCard(
                  hike.name,
                  hike.description,
                  hike.imagePath,
                );
              },
            ),
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
          child: Image.asset(
            imagePath,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          hikeName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        onTap: () {
          // Navigate to hike details
        },
      ),
    );
  }
}
