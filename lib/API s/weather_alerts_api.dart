import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchWeatherAlerts() async {
  const apiKey =
      '9ed7e19edafdda37158bfb0f7863538d'; // Replace with your OpenWeatherMap API key
  const url =
      'https://api.openweathermap.org/data/2.5/onecall?lat=YOUR_LATITUDE&lon=YOUR_LONGITUDE&exclude=hourly,daily&appid=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final alerts = data['alerts'] as List<dynamic>? ?? [];

    return alerts
        .map((alert) => {
              'event': alert['event'],
              'description': alert['description'],
              'start': alert['start'],
              'end': alert['end'],
            })
        .toList();
  } else {
    throw Exception('Failed to load weather alerts');
  }
}
