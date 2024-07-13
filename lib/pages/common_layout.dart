import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../score_manager.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;

  CommonLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: child),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<ScoreManager>(
              builder: (context, scoreManager, child) {
                return Text(
                  '내 보유 포인트: ${scoreManager.totalPoints}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.assignment),
                onPressed: () {
                  Navigator.pushNamed(context, '/mission');
                },
              ),
              IconButton(
                icon: Icon(Icons.quiz),
                onPressed: () {
                  Navigator.pushNamed(context, '/quiz');
                },
              ),
              IconButton(
                icon: Icon(Icons.local_florist),
                onPressed: () {
                  Navigator.pushNamed(context, '/garden');
                },
              ),
              IconButton(
                icon: Icon(Icons.store),
                onPressed: () {
                  Navigator.pushNamed(context, '/reward');
                },
              ),
              IconButton(
                icon: Icon(Icons.water_damage),
                onPressed: () {
                  Navigator.pushNamed(context, '/water_usage');
                },
              ),
              IconButton(
                icon: Icon(Icons.leaderboard),
                onPressed: () {
                  Navigator.pushNamed(context, '/leaderboard');
                },
              ),
              IconButton(
                icon: Icon(Icons.person_add),
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
              ),
              IconButton(
                icon: Icon(Icons.login),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile'); // '/profile'로 수정
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
