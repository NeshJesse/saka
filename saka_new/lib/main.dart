import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/image.dart';
import 'screens/account.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';

import 'screens/scrape.dart';
import 'screens/bmark.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saka BOT',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Splash(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/image',
      routes: {
        /*'/home': (context) => DisPage(),
        */
        '/image': (context) => SearchPage(),
        '/bookmark': (context) => BookmarksPage(),
        '/account': (context) => AccountScreen(),
        '/scrape': (context) => ScrapePage(),
      },
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0; // Initialize currentIndex
  }

  final TextEditingController _searchController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

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

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    String fileName = _selectedImage!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(_selectedImage!.path,
          filename: fileName),
    });

    Dio dio = Dio();
    try {
      var response =
          await dio.post("http://127.0.0.1:5000//upload", data: formData);
      if (response.statusCode == 200) {
        print("Image uploaded successfully");
      } else {
        print("Image upload failed");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SakaPrice"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        backgroundColor: Colors.lightBlue[100],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.book_rounded),
            tooltip: 'New Saka',
            onPressed: () {
              // Handle account circle button press
              // Navigate to the Progress screen
              Navigator.pushNamed(context, '/scrape');
            },
          ),
        ],
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
                onTap: _pickImage,
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
            if (_selectedImage != null) ...[
              SizedBox(height: 10),
              Image.file(_selectedImage!),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Upload Image'),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[300]!, // Border color
              width: 1.0, // Border width
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int newIndex) {
            // Navigate to the selected screen based on index
            switch (newIndex) {
              case 0:
                Navigator.pushNamed(context, '/image');
                break;
              case 1:
                Navigator.pushNamed(context, '/bookmark');
                break;
              case 2:
                Navigator.pushNamed(context, '/account');
                break;
            }
          },
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.lightBlue[200],
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark), label: 'Bookmark'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: 'Account'),
          ],
          elevation: 8,
          unselectedLabelStyle:
              TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;

  FeatureCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
