import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '0b95c7d0cde54b18852154334241309';

  Future<List<Map<String, String>>> fetchWeatherData(
      List<String> cities) async {
    List<Map<String, String>> weatherDataList = [];

    for (String city in cities) {
      final url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=imperial');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final weatherData = jsonDecode(response.body);
        final String temperature = weatherData['main']['temp'].toString();
        final String condition = weatherData['weather'][0]['main'];
        final String iconCode = weatherData['weather'][0]['icon'];
        final String iconUrl =
            'http://openweathermap.org/img/wn/$iconCode@2x.png';

        weatherDataList.add({
          "city": city,
          "temp": "$temperature°F",
          "condition": condition,
          "iconUrl": iconUrl,
        });
      }
    }

    return weatherDataList;
  }
}
