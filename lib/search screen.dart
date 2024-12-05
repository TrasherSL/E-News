import 'package:flutter/material.dart';
import 'package:news_app/news_service.dart';
class SearchScreen extends StatelessWidget {
  final NewsService newsService;

  const SearchScreen({required this.newsService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search input field
            TextField(
              decoration: InputDecoration(
                labelText: 'Search for news...',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Here, you can trigger a search on every change, if needed
                // but currently it won't show any results
              },
            ),
            SizedBox(height: 20),
            // Display a message since we won't show articles
            Center(child: Text('Search for news articles')),
          ],
        ),
      ),
    );
  }
}