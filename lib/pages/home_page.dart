import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: EdgeInsets.all(10.0),
              shrinkWrap: true,
              children: [
                _buildGridItem(
                    context, Icons.assignment, '미션', '/mission', '미션을 수행하세요'),
                _buildGridItem(context, Icons.quiz, '퀴즈', '/quiz', '퀴즈를 풀어보세요'),
                _buildGridItem(context, Icons.local_florist, '가든', '/garden',
                    '나만의 나무를 키우세요'),
                _buildGridItem(
                    context, Icons.store, '상점', '/reward', '나무 키우기 아이템을 구매하세요'),
                _buildGridItem(context, Icons.water_damage, '물 사용량',
                    '/water_usage', '물 사용량을 확인하세요'),
                _buildGridItem(context, Icons.leaderboard, '리더보드',
                    '/leaderboard', '리더보드를 확인하세요'),
                _buildGridItem(
                    context, Icons.person_add, '회원가입', '/signup', '회원가입을 해주세요'),
                _buildGridItem(context, Icons.login, '로그인', '/login', '로그인하세요'),
                _buildGridItem(context, Icons.person, '프로필', '/profile',
                    '프로필을 확인하세요'), // 프로필로 변경
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, IconData icon, String label,
      String route, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),
            SizedBox(height: 5),
            Text(label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(description,
                style: TextStyle(fontSize: 10), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
