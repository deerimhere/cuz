import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_score.dart';

class ScoreManager extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _totalPoints = 0;
  int _appleCount = 0;
  List<UserScore> _leaderboard = [];

  int get totalPoints => _totalPoints;
  int get appleCount => _appleCount;
  List<UserScore> get leaderboard => _leaderboard;

  Future<void> setPoints(int points) async {
    try {
      String userId = "user-id"; // 실제 유저 ID를 여기에 설정
      await _firestore.collection('users').doc(userId).set({
        'totalPoints': points,
      }, SetOptions(merge: true));
      _totalPoints = points;
      notifyListeners();
    } catch (e) {
      print("Failed to set points: $e");
    }
  }

  Future<void> addPoints(int points) async {
    try {
      String userId = "user-id"; // 실제 유저 ID를 여기에 설정
      _totalPoints += points;
      await _firestore.collection('users').doc(userId).update({
        'totalPoints': _totalPoints,
      });
      notifyListeners();
    } catch (e) {
      print("Failed to add points: $e");
    }
  }

  Future<void> subtractPoints(int points) async {
    try {
      String userId = "user-id"; // 실제 유저 ID를 여기에 설정
      _totalPoints -= points;
      await _firestore.collection('users').doc(userId).update({
        'totalPoints': _totalPoints,
      });
      notifyListeners();
    } catch (e) {
      print("Failed to subtract points: $e");
    }
  }

  Future<void> setAppleCount(int count) async {
    try {
      String userId = "user-id"; // 실제 유저 ID를 여기에 설정
      await _firestore.collection('users').doc(userId).set({
        'appleCount': count,
      }, SetOptions(merge: true));
      _appleCount = count;
      notifyListeners();
    } catch (e) {
      print("Failed to set apple count: $e");
    }
  }

  Future<void> addApple() async {
    try {
      String userId = "user-id"; // 실제 유저 ID를 여기에 설정
      _appleCount += 1;
      await _firestore.collection('users').doc(userId).update({
        'appleCount': _appleCount,
      });
      notifyListeners();
    } catch (e) {
      print("Failed to add apple: $e");
    }
  }

  Future<void> loadScoreData() async {
    try {
      String userId = "user-id"; // 실제 유저 ID를 여기에 설정
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      _totalPoints = data?['totalPoints'] ?? 0;
      _appleCount = data?['appleCount'] ?? 0;
      notifyListeners();
    } catch (e) {
      print("Failed to load score data: $e");
    }
  }

  Future<void> loadLeaderboard() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('leaderboard')
          .orderBy('score', descending: true)
          .get();
      _leaderboard = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserScore(
          data['name'],
          data['score'],
          data['apples'],
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Failed to load leaderboard: $e");
    }
  }

  void updateLeaderboard(List<UserScore> leaderboard) {
    _leaderboard = leaderboard;
    notifyListeners();
  }

  // 임의의 데이터를 추가하는 메서드
  void generateMockData() {
    _leaderboard = [
      UserScore('뽀짝한 지민이', 1500, 10),
      UserScore('그지같은 상욱이', 1400, 8),
      UserScore('잘생긴 범준이', 1300, 7),
      UserScore('붙잡힌 병현이', 1200, 5),
      UserScore('User5', 1100, 3),
      UserScore('User6', 1000, 2),
    ];
    notifyListeners();
  }
}
