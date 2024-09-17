import 'package:flutter/material.dart';
import 'package:hiking_app/Homepage/weather_alerts_api.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Future<Map<String, dynamic>>? _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = fetchNews()
        as Future<Map<String, dynamic>>?; // Replace with desired city
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _weatherFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final weather = snapshot.data!;
          return _buildWeatherCard(
            weather['temperature'].toString(),
            weather['description'],
            weather['icon'],
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget _buildWeatherCard(
      String temperature, String description, String iconCode) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white.withOpacity(0.8),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.network(
              'http://openweathermap.org/img/wn/$iconCode@2x.png',
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
                    'Temperature: $temperature°C',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Description: $description',
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
}
