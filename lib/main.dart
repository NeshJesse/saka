import 'package:flutter/material.dart';
import 'screens/chat.dart';
import 'splash.dart';
import 'screens/image.dart';
import 'screens/apps.dart';
import 'screens/account.dart';

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
      routes: {
        '/apps': (context) => AppScreen(),
        '/home': (context) => MainPage(),
        '/chat': (context) => ChatScreen(),
        '/image': (context) => SearchScreen(),
        '/account': (context) => AccountScreen(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0; // Initialize currentIndex
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HistMan"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        backgroundColor: Colors.greenAccent[400],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.bar_chart_rounded),
            tooltip: 'Progress',
            onPressed: () {
              // Handle account circle button press
              // Navigate to the Progress screen
              Navigator.pushNamed(context, '/progress');
            },
          ),
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [],
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
                Navigator.pushNamed(context, '/apps');
                break;
              case 1:
                Navigator.pushNamed(context, '/home');
                break;
              case 2:
                Navigator.pushNamed(context, '/chat');
                break;
              case 3:
                Navigator.pushNamed(context, '/image');
                break;
              case 4:
                Navigator.pushNamed(context, '/account');
                break;
            }
          },
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Apps'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_rounded), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active_rounded),
                label: 'Alerts'),
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
