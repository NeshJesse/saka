import 'package:flutter/material.dart';

class DisPage extends StatefulWidget {
  @override
  _DisPageState createState() => _DisPageState();
}

class _DisPageState extends State<DisPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Features Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              FeatureCard(
                title: "Set Reminders",
                description:
                    "Stay alerted on your bills by creating personalized reminders that would appear in your calendar to avoid paying late fee.",
              ),
              SizedBox(height: 16),
              FeatureCard(
                title: "Manage Bills",
                description:
                    "Keep all your bills in one place - from electricity, internet, fuel to child support bills. Take control and track them easily.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
class Display extends StatelessWidget {
  const Display({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Features Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              FeatureCard(
                title: "Set Reminders",
                description:
                    "Stay alerted on your bills by creating personalized reminders that would appear in your calendar to avoid paying late fee.",
              ),
              SizedBox(height: 16),
              FeatureCard(
                title: "Manage Bills",
                description:
                    "Keep all your bills in one place - from electricity, internet, fuel to child support bills. Take control and track them easily.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

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
