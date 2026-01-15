import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/leaderboard/domain/models/score_record.dart';
import 'logger_service.dart';

class LeaderboardService {
  LeaderboardService._();

  static const String _leaderboardKey = 'leaderboard_scores';
  static const int _maxRecords = 10;

  static Future<List<ScoreRecord>> getLeaderboard() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_leaderboardKey);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      final List<ScoreRecord> records = jsonList
          .map((json) => ScoreRecord.fromJson(json as Map<String, dynamic>))
          .toList();

      records.sort((a, b) => b.score.compareTo(a.score));
      return records;
    } catch (e, stackTrace) {
      LoggerService.error(
        'Failed to get leaderboard',
        e,
        stackTrace,
      );
      return [];
    }
  }

  static Future<void> saveScore(int score) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_leaderboardKey);
      
      List<ScoreRecord> records;
      if (jsonString == null || jsonString.isEmpty) {
        records = [];
      } else {
        final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
        records = jsonList
            .map((json) => ScoreRecord.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      final newRecord = ScoreRecord(
        score: score,
        timestamp: DateTime.now(),
      );

      records.add(newRecord);
      records.sort((a, b) => b.score.compareTo(a.score));

      final topRecords = records.take(_maxRecords).toList();
      final jsonList = topRecords.map((record) => record.toJson()).toList();
      final jsonStringNew = jsonEncode(jsonList);

      await prefs.setString(_leaderboardKey, jsonStringNew);
      LoggerService.info('Score saved: $score');
    } catch (e, stackTrace) {
      LoggerService.error(
        'Failed to save score',
        e,
        stackTrace,
      );
    }
  }

  static Future<void> clearLeaderboard() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_leaderboardKey);
      LoggerService.info('Leaderboard cleared');
    } catch (e, stackTrace) {
      LoggerService.error(
        'Failed to clear leaderboard',
        e,
        stackTrace,
      );
    }
  }
}

