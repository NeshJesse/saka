import 'package:flutter/material.dart';
import 'screens/chat.dart';
import 'splash.dart';
import 'screens/image.dart';
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
        '/home': (context) => MainPage(),
        '/image': (context) => SearchScreen(),
        '/account': (context) => AccountScreen(),
        '/chat': (context) => ChatScreen(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}
