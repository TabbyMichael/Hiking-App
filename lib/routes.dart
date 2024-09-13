import 'package:flutter/material.dart';
import 'package:hiking_app/find_trails_screen.dart';
import 'package:hiking_app/hike_page.dart';
import 'package:hiking_app/Homepage/home_page.dart';
import 'package:hiking_app/Authentication/login.dart';
import 'package:hiking_app/maps_page.dart';
import 'package:hiking_app/profile_page.dart';
import 'package:hiking_app/settings/settings_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => HomePage(),
  '/login': (context) => const LoginPage(),
  '/profile': (context) => const ProfilePage(),
  '/maps': (context) => const MapsPage(),
  '/findTrails': (context) => const FindTrailsScreen(),
  // '/maps': (context) => const MapsPage(),

  // Pass required arguments to HikePage
  '/hike': (context) => const HikePage(
      hikeName: "Mount Everest",
      hikeDescription: "A challenging and rewarding climb."),
  '/settings': (context) => const SettingsPage(),
};
