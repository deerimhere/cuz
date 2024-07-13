import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreManager extends ChangeNotifier {
  int _totalPoints = 0;
  int _appleCount = 0;

  int get totalPoints => _totalPoints;
  int get appleCount => _appleCount;

  Future<void> setPoints(int points) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalPoints', points);
    _totalPoints = points;
    notifyListeners();
  }

  Future<void> addPoints(int points) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _totalPoints += points;
    await prefs.setInt('totalPoints', _totalPoints);
    notifyListeners();
  }

  Future<void> subtractPoints(int points) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _totalPoints -= points;
    await prefs.setInt('totalPoints', _totalPoints);
    notifyListeners();
  }

  Future<void> setAppleCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('appleCount', count);
    _appleCount = count;
    notifyListeners();
  }

  Future<void> addApple() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _appleCount += 1;
    await prefs.setInt('appleCount', _appleCount);
    notifyListeners();
  }

  Future<void> loadScoreData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _totalPoints = prefs.getInt('totalPoints') ?? 0;
    _appleCount = prefs.getInt('appleCount') ?? 0;
    notifyListeners();
  }
}
