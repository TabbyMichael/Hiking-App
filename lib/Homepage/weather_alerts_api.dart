import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey =
    '9ed7e19edafdda37158bfb0f7863538d '; // Replace with your News API key
const String baseUrl =
    'https://newsapi.org/v2/top-headlines'; // Example API endpoint

Future<List<Map<String, dynamic>>> fetchNews() async {
  const url =
      '$baseUrl?country=us&apiKey=$apiKey'; // Example endpoint for US news

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final articles = data['articles'] as List;
      return articles.map((article) {
        return {
          'title': article['title'],
          'description': article['description'],
          'urlToImage':
              article['urlToImage'] ?? 'https://via.placeholder.com/150',
        };
      }).toList();
    } else {
      throw Exception(
          'Failed to load news. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching news: $e');
    throw Exception('Error fetching news: $e');
  }
}
