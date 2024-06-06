import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saka Bot'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button
            Navigator.pushNamed(context, '/home');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options
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
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8.0),
                          Text('Analyze UX for Job Finder app'),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Key aspects of a job finder app\'s UX analysis:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ..._buildKeyAspects(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          SizedBox(width: 8.0),
                          Text('Onboarding copy for it'),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Sure, here\'s some option for onboarding Copy for Job Finder App:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ..._buildOnboardingCopy(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Send a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  // Handle send button
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildKeyAspects() {
    const keyAspects = [
      'Seamless onboarding process',
      'Intuitive search and filtering',
      'Clear and organized job listings',
      'Personalized job recommendations',
      'Easy application process',
      'Communication and collaboration features',
      'User feedback and support options',
      'Accessibility considerations',
      'Performance and speed',
      'Visual design and branding consistency',
    ];
    return keyAspects.map((aspect) => Text('- $aspect')).toList();
  }

  List<Widget> _buildOnboardingCopy() {
    const onboardingCopy = [
      'Welcome! Personalize your job search with a few taps. Let\'s find you the perfect fit!',
      'Let\'s customize your job search! Tell us your preferences to find your dream job.',
      'Get started on your job search! Share your job interests and location for personalized recommendations.',
    ];
    return onboardingCopy.map((copy) => Text('- $copy')).toList();
  }
}
