import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _fetchTopUsers() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .orderBy('score', descending: true)
        .limit(3)
        .get();

    return querySnapshot.docs
        .map((doc) => {"name": doc["name"], "score": doc["score"]})
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리더보드'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchTopUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류가 발생했습니다.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('데이터가 없습니다.'));
          } else {
            List<Map<String, dynamic>> topUsers = snapshot.data!;
            return Column(
              children: [
                _buildPodium(topUsers),
                Expanded(
                  child: ListView.builder(
                    itemCount: topUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(topUsers[index]['name']),
                        trailing: Text('점수: ${topUsers[index]['score']}'),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildPodium(List<Map<String, dynamic>> topUsers) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (topUsers.length > 1)
            Column(
              children: [
                Text(
                  '2등',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  width: 60,
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      topUsers[1]['name'],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('점수: ${topUsers[1]['score']}'),
              ],
            ),
          if (topUsers.length > 0)
            Column(
              children: [
                Text(
                  '1등',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  height: 120,
                  width: 60,
                  color: Colors.yellow,
                  child: Center(
                    child: Text(
                      topUsers[0]['name'],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('점수: ${topUsers[0]['score']}'),
              ],
            ),
          if (topUsers.length > 2)
            Column(
              children: [
                Text(
                  '3등',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  height: 80,
                  width: 60,
                  color: Colors.brown,
                  child: Center(
                    child: Text(
                      topUsers[2]['name'],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('점수: ${topUsers[2]['score']}'),
              ],
            ),
        ],
      ),
    );
  }
}
