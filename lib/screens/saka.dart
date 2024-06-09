import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  List<String> recentSearches = [
    "romance",
    "Robert Greene",
    "the story of God",
    "contemporary challenges in education",
    "the impact of digitalization in a change"
  ];

  List<String> recommendedSearches = [
    "Robert’s birthday present",
    "The art of seduction",
    "Robert the Bruce",
    "the curse of Robert",
    "the revenge of Robert",
    "mister Robert"
  ];

  void _clearRecentSearch(int index) {
    setState(() {
      recentSearches.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.arrow_upward),
                  onPressed: () {
                    // Define your submit action here
                    print("Search submitted: ${_searchController.text}");
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: InkWell(
                onTap: () {
                  // Define your onTap action here
                },
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.image, size: 30),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Click to upload image',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent search',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      recentSearches.clear();
                    });
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(recentSearches[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => _clearRecentSearch(index),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Recommended',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recommendedSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(recommendedSearches[index]),
                    trailing: Icon(Icons.search),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
