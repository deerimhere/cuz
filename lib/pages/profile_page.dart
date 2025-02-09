import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import '../models/tree_model.dart';
import 'common_layout.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = "user-id"; // 실제 유저 ID를 여기에 설정

  Future<String?> _getNickname() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(userId).get();
    return (snapshot.data() as Map<String, dynamic>?)?['nickname'];
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20), // 상단 여백 조정
                Consumer<TreeManager>(
                  builder: (context, treeManager, child) {
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0), // 패딩 조정
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (treeManager.tree.level == 0)
                              Lottie.asset(
                                'assets/animation_cry.json',
                                width: 80, // 이미지 너비 조정
                                height: 80, // 이미지 높이 조정
                              )
                            else
                              Image.asset(
                                'assets/images/level${treeManager.tree.level}.png',
                                width: 80, // 이미지 너비 조정
                                height: 80, // 이미지 높이 조정
                              ),
                            SizedBox(width: 15), // 간격 조정
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder<String?>(
                                  future: _getNickname(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Text(
                                        snapshot.data ?? '닉네임 없음',
                                        style: TextStyle(
                                          fontSize: 18, // 글자 크기 조정
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '내 나무의 현재 상태',
                                  style: TextStyle(
                                    fontSize: 16, // 글자 크기 조정
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '레벨: ${treeManager.tree.level}',
                                  style: TextStyle(fontSize: 16), // 글자 크기 조정
                                ),
                                Text(
                                  '경험치: ${treeManager.tree.experience} / 3500',
                                  style: TextStyle(fontSize: 16), // 글자 크기 조정
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
