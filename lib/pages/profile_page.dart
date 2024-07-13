import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import '../models/tree_model.dart';
import 'common_layout.dart';

class ProfilePage extends StatelessWidget {
  Future<String?> _getNickname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nickname');
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
                SizedBox(height: 40), // 상단 여백 조정
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
                                width: 104, // 이미지 너비 30% 증가
                                height: 104, // 이미지 높이 30% 증가
                              )
                            else
                              Image.asset(
                                'assets/images/level${treeManager.tree.level}.png',
                                width: 104, // 이미지 너비 30% 증가
                                height: 104, // 이미지 높이 30% 증가
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
                                          fontSize: 23, // 글자 크기 증가
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
                                    fontSize: 19, // 글자 크기 증가
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '레벨: ${treeManager.tree.level}',
                                  style: TextStyle(fontSize: 19), // 글자 크기 증가
                                ),
                                Text(
                                  '경험치: ${treeManager.tree.experience} / 3500',
                                  style: TextStyle(fontSize: 19), // 글자 크기 증가
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
