import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;

  const BottomNavBar({super.key, required this.onTap, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[800]!, Colors.grey[600]!], // Gradient background
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: [
          _buildNavBarItem(Icons.home, "Home"),
          _buildNavBarItem(Icons.map, "Map"),
          _buildNavBarItem(Icons.hiking, "New Hike"),
          _buildNavBarItem(Icons.person, "Profile"),
        ],
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        backgroundColor: const Color.fromARGB(255, 109, 79, 68),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
