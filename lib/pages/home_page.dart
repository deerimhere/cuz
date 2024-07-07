import 'package:flutter/material.dart';
import '../score_manager.dart'; // 추가

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalPoints = 0;

  @override
  void initState() {
    super.initState();
    _loadTotalPoints();
  }

  Future<void> _loadTotalPoints() async {
    int points = await ScoreManager.getTotalPoints();
    setState(() {
      totalPoints = points;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('수자원공사 공모전 시범 앱'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('환영합니다!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    // 여기에 원래 있던 내용이 들어갑니다
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '내 보유 포인트: $totalPoints',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
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
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              IconButton(
                icon: Icon(Icons.login),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              IconButton(
                icon: Icon(Icons.person_add),
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
              ),
              IconButton(
                icon: Icon(Icons.bar_chart),
                onPressed: () {
                  Navigator.pushNamed(context, '/water_usage');
                },
              ),
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
                icon: Icon(Icons.redeem),
                onPressed: () {
                  Navigator.pushNamed(context, '/reward');
                },
              ),
              IconButton(
                icon: Icon(Icons.leaderboard),
                onPressed: () {
                  Navigator.pushNamed(context, '/leaderboard');
                },
              ),
              IconButton(
                icon: Icon(Icons.local_florist),
                onPressed: () {
                  Navigator.pushNamed(context, '/garden');
                },
              ),
              IconButton(
                icon: Icon(Icons.forum),
                onPressed: () {
                  Navigator.pushNamed(context, '/community');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
