import 'package:flutter/material.dart';
import 'package:news_app/news_article.dart';
import 'package:news_app/news_details_screen.dart';

class BookmarkScreen extends StatefulWidget {
  final List<NewsArticle> bookmarkedArticles;

  const BookmarkScreen({Key? key, required this.bookmarkedArticles}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
      ),
      body: widget.bookmarkedArticles.isEmpty
          ? Center(child: Text("No bookmarks added yet!"))
          : ListView.builder(
        itemCount: widget.bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = widget.bookmarkedArticles[index];
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
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Show a confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Remove Bookmark"),
                      content: Text("Are you sure you want to remove this bookmark?"),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text("Remove"),
                          onPressed: () {
                            setState(() {
                              widget.bookmarkedArticles.removeAt(index);
                            });
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            onTap: () {
              // Optional: Navigate to article detail screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailScreen(article: article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
