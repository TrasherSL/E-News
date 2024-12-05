import 'package:flutter/material.dart';
import 'package:news_app/news_article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailScreen extends StatelessWidget {
  final NewsArticle article;

  ArticleDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.imageUrl.isNotEmpty
                ? Image.network(article.imageUrl)
                : SizedBox.shrink(),
            SizedBox(height: 16),
            Text(
              article.title,
              style: Theme.of(context).textTheme.titleLarge, // Use titleLarge for a larger title
            ),
            SizedBox(height: 8),
            Text(
              article.content,
              style: Theme.of(context).textTheme.bodyLarge, // Use bodyLarge for larger body text
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Open the article URL in a web browser
                _launchURL(article.url);
              },
              child: Text('Read Full Article'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to launch URL in the browser
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Open the URL in an external browser
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}