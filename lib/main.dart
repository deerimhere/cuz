import 'package:flutter/material.dart';
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
import 'score_manager.dart'; // 추가

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '수자원공사 공모전 시범 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
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
