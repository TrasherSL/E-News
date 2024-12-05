import 'package:flutter/material.dart';
import 'package:news_app/news_article.dart';
import 'package:news_app/news_service.dart';
import 'package:news_app/search screen.dart';
import 'package:news_app/news_details_screen.dart';
import 'package:news_app/settings_screen.dart';
import 'package:news_app/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
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
  String selectedCategory = 'general';
  List<NewsArticle> bookmarkedArticles = []; // To store bookmarked articles

  List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-News'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(newsService: newsService),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookmarkScreen(bookmarkedArticles: bookmarkedArticles),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Category dropdown
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: selectedCategory,
                onChanged: (newCategory) {
                  setState(() {
                    selectedCategory = newCategory!;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category.toUpperCase()),
                  );
                }).toList(),
              ),
            ),
            // News articles list
            FutureBuilder<List<NewsArticle>>(
              future: newsService.fetchArticles(selectedCategory),
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
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                        trailing: IconButton(
                          icon: Icon(
                            bookmarkedArticles.contains(articles[index])
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: bookmarkedArticles.contains(articles[index]) ? Colors.blue : null,
                          ),
                          onPressed: () {
                            setState(() {
                              if (bookmarkedArticles.contains(articles[index])) {
                                bookmarkedArticles.remove(articles[index]);
                              } else {
                                bookmarkedArticles.add(articles[index]);
                              }
                            });
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleDetailScreen(
                                article: articles[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Bookmark Screen Implementation
class BookmarkScreen extends StatelessWidget {
  final List<NewsArticle> bookmarkedArticles;

  const BookmarkScreen({Key? key, required this.bookmarkedArticles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
      ),
      body: bookmarkedArticles.isEmpty
          ? Center(child: Text("No bookmarks added yet!"))
          : ListView.builder(
        itemCount: bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = bookmarkedArticles[index];
          return ListTile(
            leading: article.imageUrl.isNotEmpty
                ? Image.network(
              article.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            )
                : Icon(Icons.image_not_supported),
            title: Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              article.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              // Optional: Navigate to article detail screen
            },
          );
        },
      ),
    );
  }
}
