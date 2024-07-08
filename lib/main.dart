import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'score_manager.dart';
import 'data.dart';
import 'pages/home_page.dart';
import 'pages/reward_page.dart';
import 'pages/quiz_page.dart';
import 'pages/garden_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScoreManager()),
        ChangeNotifierProvider(create: (context) => ItemData()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '퀴즈 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/quiz': (context) => QuizPage(),
        '/reward': (context) => RewardPage(),
        '/garden': (context) => GardenPage(),
      },
    );
  }
}
