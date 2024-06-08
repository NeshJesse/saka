import 'package:flutter/material.dart';

class FtBox extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String buttonText1;
  final String buttonText2;

  const FtBox({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.buttonText1,
    required this.buttonText2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.lightBlue[200],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle button 1 action
                  },
                  child: Text(buttonText1),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle button 2 action
                  },
                  child: Text(buttonText2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
