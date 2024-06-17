import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
