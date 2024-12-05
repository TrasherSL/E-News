import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/news_article.dart';

class NewsService {
  static const String apiKey = 'a0b55a6092f347c380863c39aae613ce';
  static const String baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> fetchArticles(String category, {int page = 1, int pageSize = 20}) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/top-headlines?category=$category&page=$page&pageSize=$pageSize&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['articles'] is List) {
          return (data['articles'] as List).map((json) => NewsArticle.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected response format: No articles found');
        }
      } else {
        throw Exception('Failed to load articles: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching articles: $e');
    }
  }
}