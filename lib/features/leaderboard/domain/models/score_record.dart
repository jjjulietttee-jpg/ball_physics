import 'package:equatable/equatable.dart';

class ScoreRecord extends Equatable {
  final int score;
  final DateTime timestamp;

  const ScoreRecord({
    required this.score,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ScoreRecord.fromJson(Map<String, dynamic> json) {
    return ScoreRecord(
      score: json['score'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  @override
  List<Object> get props => [score, timestamp];
}

