import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/energy.dart';
import 'package:flutter_health_connect/src/utils.dart';

import 'interval_record.dart';

class ActiveCaloriesBurnedRecord extends IntervalRecord {
  Energy? energy;
  @override
  DateTime endTime;
  @override
  Duration? endZoneOffset;
  @override
  Metadata metadata;
  @override
  DateTime startTime;
  @override
  Duration? startZoneOffset;

  ActiveCaloriesBurnedRecord(
      {required this.startTime,
      this.startZoneOffset,
      required this.endTime,
      this.endZoneOffset,
      required this.energy,
      metadata})
      : assert(energy == null || energy.value >= 0, 'Energy must be positive'),
        assert(
            startTime.isBefore(endTime), 'Start time must be before end time'),
        assert(energy == null || energy.value <= maxEnergy.value,
            'Energy must be less than $maxEnergy'),
        metadata = metadata ?? Metadata.empty();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveCaloriesBurnedRecord &&
          energy == other.energy &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset;

  @override
  int get hashCode =>
      energy.hashCode ^
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode;

  static Energy maxEnergy = const Energy.kilocalories(1000000);

  @override
  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'energy': energy?.inKilocalories,
      'metadata': metadata.toMap(),
    };
  }

  @override
  factory ActiveCaloriesBurnedRecord.fromMap(Map<String, dynamic> map) {
    return ActiveCaloriesBurnedRecord(
        startTime: DateTime.parse(map['startTime']),
        startZoneOffset: map['startZoneOffset'] != null
            ? parseDuration(map['startZoneOffset'])
            : null,
        endTime: DateTime.parse(map['endTime']),
        endZoneOffset: map['endZoneOffset'] != null
            ? parseDuration(map['endZoneOffset'])
            : null,
        energy: map['energy'] != null
            ? Energy.fromMap(Map<String, dynamic>.from(map['energy']))
            : null,
        metadata: map['metadata'] != null
            ? Metadata.fromMap(Map<String, dynamic>.from(map['metadata']))
            : Metadata.empty());
  }

  @override
  String toString() {
    return 'ActiveCaloriesBurnedRecord{energy: $energy, endTime: $endTime, endZoneOffset: $endZoneOffset, metadata: $metadata, startTime: $startTime, startZoneOffset: $startZoneOffset}';
  }
}
