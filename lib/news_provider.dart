import 'package:flutter/material.dart';
import 'package:news_app/news_article.dart';
import 'package:news_app/news_service.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsArticle> _articles = [];
  bool _isLoading = false;

  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;

  final NewsService _newsService = NewsService();

  Future<void> fetchArticles(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsService.fetchArticles(query);
    } catch (e) {
      _articles = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
