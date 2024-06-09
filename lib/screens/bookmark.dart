import 'package:flutter/material.dart';

void main() {
  runApp(BookmarksApp());
}

class BookmarksApp extends StatelessWidget {
  const BookmarksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookmarks Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookmarksPage(),
    );
  }
}

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My bookmarks'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new bookmark
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Show all',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Unread',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Folders',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16),
              BookmarksList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Apps'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'Bookmark'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: 'Account'),
        ],
      ),
    );
  }
}

class BookmarksList extends StatelessWidget {
  final List<Map<String, String>> bookmarks = [
    {
      'category': 'IN HEALTH',
      'title': 'Do plants brighten up your day?',
      'source': 'on Medium',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'category': 'IN WORK',
      'title': 'When to hire devs',
      'source': 'on Indiehackers',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'category': 'reedy',
      'title': 'Put an end to your bookmark limit',
      'source': '',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'category': 'IN DESIGN',
      'title': 'Why do we hate brand redesigns?',
      'source': '',
      'imageUrl': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: bookmarks.map((bookmark) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: Image.network(
                bookmark['imageUrl']!,
                width: 60,
                fit: BoxFit.cover,
              ),
              title: Text(
                bookmark['category']!,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    bookmark['title']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (bookmark['source']!.isNotEmpty) SizedBox(height: 8),
                  if (bookmark['source']!.isNotEmpty)
                    Text(
                      bookmark['source']!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
