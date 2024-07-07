import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'score_manager.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/water_usage_page.dart';
import 'pages/mission_page.dart';
import 'pages/quiz_page.dart';
import 'pages/reward_page.dart';
import 'pages/leaderboard_page.dart';
import 'pages/garden_page.dart';
import 'pages/community_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScoreManager()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Saving Challenge',
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/water_usage': (context) => WaterUsagePage(),
        '/mission': (context) => MissionPage(),
        '/quiz': (context) => QuizPage(),
        '/reward': (context) => RewardPage(),
        '/leaderboard': (context) => LeaderboardPage(),
        '/garden': (context) => GardenPage(),
        '/community': (context) => CommunityPage(),
      },
    );
  }
}
