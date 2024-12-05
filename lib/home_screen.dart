import 'package:flutter/material.dart';
import 'package:news_app/news_article.dart';
import 'package:news_app/news_service.dart';
import 'package:news_app/main.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final NewsService newsService = NewsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to SearchScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(newsService: newsService),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: newsService.fetchArticles('general'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No articles found'));
          } else {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: articles[index].imageUrl.isNotEmpty
                      ? Image.network(
                    articles[index].imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                      : Icon(Icons.image_not_supported),
                  title: Text(
                    articles[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    articles[index].description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    // Handle article click (e.g., navigate to a detail screen)
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  final NewsService newsService;
  const SearchScreen({required this.newsService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search News'),
      ),
      body: SearchDelegateWidget(newsService: newsService),
    );
  }
}

class SearchDelegateWidget extends StatelessWidget {
  final NewsService newsService;
  const SearchDelegateWidget({required this.newsService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsArticle>>(
      future: newsService.fetchArticles('general'), // Default or searched keyword
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No results found.'));
        } else {
          final articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: articles[index].imageUrl.isNotEmpty
                    ? Image.network(
                  articles[index].imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
                    : Icon(Icons.image_not_supported),
                title: Text(
                  articles[index].title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  articles[index].description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  // Handle article click
                },
              );
            },
          );
        }
      },
    );
  }
}
