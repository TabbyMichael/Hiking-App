import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HikePage extends StatefulWidget {
  final String hikeName;
  final String hikeDescription;

  const HikePage(
      {super.key, required this.hikeName, required this.hikeDescription});

  @override
  _HikePageState createState() => _HikePageState();
}

class _HikePageState extends State<HikePage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = []; // Store recent searches
  final List<String> _autocompleteSuggestions = []; // Example suggestions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              options: MapOptions(
                center: const LatLng(34.0522, -118.2437), // Example coordinates
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                // Additional layers or markers can be added here
              ],
            ),
          ),
          // Back button and Search field
          Positioned(
            top: 40, // Adjust position if necessary
            left: 16,
            right: 16,
            child: Row(
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back
                  },
                ),
                Expanded(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search trails...',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        // Handle autocomplete suggestions
                        setState(() {
                          _autocompleteSuggestions
                              .clear(); // Fetch suggestions based on value
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Show autocomplete suggestions
          if (_autocompleteSuggestions.isNotEmpty)
            Positioned(
              top: 80, // Adjust position based on search field
              left: 16,
              right: 16,
              child: Material(
                elevation: 5.0,
                child: Column(
                  children: _autocompleteSuggestions.map((suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                      onTap: () {
                        // Handle suggestion tap
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          // Show recent searches
          if (_recentSearches.isNotEmpty)
            Positioned(
              top: 80, // Adjust position based on search field
              left: 16,
              right: 16,
              child: Material(
                elevation: 5.0,
                child: Column(
                  children: _recentSearches.map((search) {
                    return ListTile(
                      title: Text(search),
                      onTap: () {
                        // Handle recent search tap
                        _searchController.text = search;
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Show search dialog with autocomplete and filter options
  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Hikes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Autocomplete text field
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search trails...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  ),
                ),
                onChanged: (value) {
                  // Handle autocomplete suggestions
                  setState(() {
                    _autocompleteSuggestions
                        .clear(); // Fetch suggestions based on value
                  });
                },
              ),
              // Display autocomplete suggestions
              if (_autocompleteSuggestions.isNotEmpty)
                Column(
                  children: _autocompleteSuggestions.map((suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                      onTap: () {
                        // Handle suggestion tap
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              // Recent searches
              if (_recentSearches.isNotEmpty)
                Column(
                  children: _recentSearches.map((search) {
                    return ListTile(
                      title: Text(search),
                      onTap: () {
                        // Handle recent search tap
                        _searchController.text = search;
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Search'),
              onPressed: () {
                // Perform search action
                final searchText = _searchController.text;
                if (searchText.isNotEmpty) {
                  setState(() {
                    _recentSearches.add(searchText); // Save search to history
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
