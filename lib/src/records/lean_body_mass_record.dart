import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/mass.dart';
import 'package:flutter_health_connect/src/utils.dart';

class LeanBodyMassRecord extends InstantaneousRecord {
  @override
  Metadata metadata;
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  Mass? mass;

  LeanBodyMassRecord(
      {required this.time, this.zoneOffset, required this.mass, metadata})
      : metadata = metadata ?? Metadata.empty(),
        assert(mass == null ||
            (mass.inKilograms >= _minMass.inKilograms &&
                mass.inKilograms <= _maxMass.inKilograms));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeanBodyMassRecord &&
          metadata == other.metadata &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          mass == other.mass;

  @override
  int get hashCode =>
      metadata.hashCode ^ time.hashCode ^ zoneOffset.hashCode ^ mass.hashCode;

  static const Mass _minMass = Mass.kilograms(0);
  static const Mass _maxMass = Mass.kilograms(1000);

  @override
  Map<String, dynamic> toMap() {
    return {
      'metadata': metadata.toMap(),
      'time': time.toUtc().toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'mass': mass?.inKilograms,
    };
  }

  @override
  factory LeanBodyMassRecord.fromMap(Map<String, dynamic> map) {
    return LeanBodyMassRecord(
      metadata: map['metadata'] != null
          ? Metadata.fromMap(Map<String, dynamic>.from(map['metadata']))
          : Metadata.empty(),
      time: DateTime.parse(map['time']),
      zoneOffset:
          map['zoneOffset'] != null ? parseDuration(map['zoneOffset']) : null,
      mass: map['mass'] != null
          ? Mass.fromMap(Map<String, dynamic>.from(map['mass']))
          : null,
    );
  }

  @override
  String toString() {
    return 'LeanBodyMassRecord{metadata: $metadata, time: $time, zoneOffset: $zoneOffset, mass: $mass}';
  }
}
