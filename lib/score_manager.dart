import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreManager extends ChangeNotifier {
  int _totalPoints = 0;

  int get totalPoints => _totalPoints;

  ScoreManager() {
    _loadTotalPoints();
  }

  Future<void> _loadTotalPoints() async {
    final prefs = await SharedPreferences.getInstance();
    _totalPoints = prefs.getInt('totalPoints') ?? 0;
    notifyListeners();
  }

  Future<void> addPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    _totalPoints += points;
    await prefs.setInt('totalPoints', _totalPoints);
    notifyListeners();
  }

  Future<void> subtractPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    _totalPoints -= points;
    await prefs.setInt('totalPoints', _totalPoints);
    notifyListeners();
  }

  Future<void> setPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    _totalPoints = points;
    await prefs.setInt('totalPoints', _totalPoints);
    notifyListeners();
  }

  Future<int> getTotalPoints() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('totalPoints') ?? 0;
  }
}
