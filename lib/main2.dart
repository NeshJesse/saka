import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  final String title;
  final String description;

  const ExploreCard({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
