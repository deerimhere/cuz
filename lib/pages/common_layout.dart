import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonLayout extends StatefulWidget {
  final Widget child;

  CommonLayout({required this.child});

  @override
  _CommonLayoutState createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> {
  int totalPoints = 0;

  @override
  void initState() {
    super.initState();
    _loadTotalPoints();
  }

  Future<void> _loadTotalPoints() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalPoints = prefs.getInt('totalPoints') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: widget.child),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '내 보유 포인트: $totalPoints',
              style: TextStyle(fontSize: 16, color: Colors.black),
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
