import 'package:flutter_health_connect/src/units/length.dart';

class ExerciseLap {
  DateTime startTime;
  DateTime endTime;
  Length? length;

  ExerciseLap({
    required this.startTime,
    required this.endTime,
    this.length,
  })  : assert(startTime.isBefore(endTime),
            "startTime must not be after endTime."),
        assert(
            length == null ||
                (length.inMeters >= _minLength.inMeters &&
                    length.inMeters <= _maxLength.inMeters),
            "length must be between $_minLength and $_maxLength");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseLap &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          length == other.length;

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode ^ length.hashCode;

  static const Length _minLength = Length.meters(0);
  static const Length _maxLength = Length.meters(1000000);

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'length': length?.inMeters,
    };
  }

  factory ExerciseLap.fromMap(Map<String, dynamic> map) {
    return ExerciseLap(
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
      length: map['length'] != null ? Length.meters(map['length']) : null,
    );
  }

  @override
  String toString() =>
      'ExerciseLap(startTime: $startTime, endTime: $endTime, length: $length)';
}
