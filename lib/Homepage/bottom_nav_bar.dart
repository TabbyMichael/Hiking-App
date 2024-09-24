import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex; // Track the current index
  final Color backgroundColor; // Custom background color
  final Color selectedItemColor; // Custom selected item color
  final Color unselectedItemColor; // Custom unselected item color

  const BottomNavBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
    this.backgroundColor = Colors.brown,
    this.selectedItemColor = Colors.white,
    this.unselectedItemColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: backgroundColor, // Set the background color
      currentIndex: currentIndex, // Set the current active item
      selectedItemColor: selectedItemColor, // Color of the selected item
      unselectedItemColor: unselectedItemColor, // Color of the unselected items
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: "Hike",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_walk),
          label: "Maps",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
      onTap: onTap,
    );
  }
}
