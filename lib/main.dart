import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'score_manager.dart';
import 'data.dart';
import 'models/tree_model.dart';
import 'pages/home_page.dart';
import 'pages/reward_page.dart';
import 'pages/quiz_page.dart';
import 'pages/garden_page.dart';
import 'pages/mission_page.dart';
import 'pages/water_usage_page.dart';
import 'pages/signup_page.dart';
import 'pages/login_page.dart';
import 'pages/leaderboard_page.dart';
import 'pages/community_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final scoreManager = ScoreManager();
  await scoreManager.setPoints(10000); // 초기화 시 10000 포인트 설정

  final treeManager = TreeManager();
  await treeManager.loadTree();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => scoreManager),
        ChangeNotifierProvider(create: (context) => ItemData()),
        ChangeNotifierProvider(create: (context) => treeManager),
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
        '/home': (context) => HomePage(), // 이 부분 추가
        '/quiz': (context) => QuizPage(),
        '/reward': (context) => RewardPage(),
        '/garden': (context) => GardenPage(),
        '/mission': (context) => MissionPage(),
        '/water_usage': (context) => WaterUsagePage(),
        '/signup': (context) => SignupPage(),
        '/login': (context) => LoginPage(),
        '/leaderboard': (context) => LeaderboardPage(),
        '/community': (context) => CommunityPage(),
      },
    );
  }
}
