import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/search.dart';
import 'screens/account.dart';
import 'screens/feat.dart';
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
      routes: {
        '/home': (context) => MainPage(),
        '/image': (context) => SearchScreen(),
        '/bookmark': (context) => BookmarksPage(),
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
        title: const Text("SakaBOT"),
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
            tooltip: 'New Chat',
            onPressed: () {
              // Handle account circle button press
              // Navigate to the Progress screen
              Navigator.pushNamed(context, '/newchat');
            },
          ),
        ],
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: [
            FtBox(
              imageUrl:
                  'https://images.unsplash.com/photo-1616832880334-b1004d9808da?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1336&q=80',
              title: 'Post to X command',
              subtitle: 'Instruct Saka to Tweet on your behalf ',
              buttonText1: 'Read More',
            ),
            FtBox(
              imageUrl:
                  'https://images.unsplash.com/photo-1616832880334-b1004d9808da?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1336&q=80',
              title: 'Image Search',
              subtitle: 'Find people using their public photos',
              buttonText1: 'Read More',
            ),
            FtBox(
              imageUrl:
                  'https://images.unsplash.com/photo-1616832880334-b1004d9808da?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1336&q=80',
              title: 'Breaking News',
              subtitle: 'Important news update',
              buttonText1: 'Read More',
            ),
            FtBox(
              imageUrl:
                  'https://images.unsplash.com/photo-1616832880334-b1004d9808da?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1336&q=80',
              title: 'Breaking News',
              subtitle: 'Important news update',
              buttonText1: 'Read More',
            ),
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
                Navigator.pushNamed(context, '/apps');
                break;
              case 1:
                Navigator.pushNamed(context, '/image');
                break;
              case 2:
                Navigator.pushNamed(context, '/bookmark');
                break;
              case 3:
                Navigator.pushNamed(context, '/account');
                break;
            }
          },
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.lightBlue[200],
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Apps'),
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
