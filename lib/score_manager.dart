import 'package:shared_preferences/shared_preferences.dart';

class ScoreManager {
  static Future<int> getTotalPoints() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('totalPoints') ?? 0;
  }

  static Future<void> updateTotalPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    int totalPoints = (prefs.getInt('totalPoints') ?? 0) + points;
    await prefs.setInt('totalPoints', totalPoints);
  }
}
