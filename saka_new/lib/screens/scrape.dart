import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScrapePage extends StatefulWidget {
  const ScrapePage({Key? key}) : super(key: key);
  @override
  _ScrapePageState createState() => _ScrapePageState();
}

class _ScrapePageState extends State<ScrapePage> {
  final TextEditingController _controller = TextEditingController();
  bool _downloadPhotos = false; // Variable to track checkbox state

  Future<void> sendData(String username, bool downloadPhotos) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/scrape'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'downloadPhotos': downloadPhotos,
      }),
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
      // You can handle the response here
      final responseData = jsonDecode(response.body);
      print(responseData);
    } else {
      print('Failed to send data');
      throw Exception('Failed to send data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter with Flask and MongoDB'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter username'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _downloadPhotos,
                  onChanged: (value) {
                    setState(() {
                      _downloadPhotos = value!;
                    });
                  },
                ),
                Text('Download Photos'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => sendData(_controller.text, _downloadPhotos),
              child: Text('Send Data'),
            ),
          ],
        ),
      ),
    );
  }
}
