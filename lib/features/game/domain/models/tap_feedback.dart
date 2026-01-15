import 'package:equatable/equatable.dart';

class TapFeedback extends Equatable {
  final String id;
  final String text;
  final double x;
  final double y;
  final DateTime timestamp;

  const TapFeedback({
    required this.id,
    required this.text,
    required this.x,
    required this.y,
    required this.timestamp,
  });

  @override
  List<Object> get props => [id, text, x, y, timestamp];
}

