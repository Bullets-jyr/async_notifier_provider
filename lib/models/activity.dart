import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'activity.freezed.dart';

part 'activity.g.dart';

@freezed
class Activity with _$Activity {
  const factory Activity({
    required String activity,
    required double availability,
    required String type,
    required int participants,
    required double price,
    required String accessibility,
    required bool kidFriendly,
    required String duration,
    required String link,
    required String key,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  factory Activity.empty() => const Activity(
        activity: '',
        availability: 0.0,
        type: '',
        participants: 0,
        price: 0.0,
        accessibility: '',
        duration: '',
        kidFriendly: false,
        link: '',
        key: '0',
      );
}

final activityTypes = [
  "education",
  "recreational",
  "social",
  "diy",
  "charity",
  "cooking",
  "relaxation",
  "music",
  "busywork"
];

enum RequestTypes { type, pariticipants }
