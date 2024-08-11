// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      activity: json['activity'] as String,
      availability: (json['availability'] as num).toDouble(),
      type: json['type'] as String,
      participants: (json['participants'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      accessibility: json['accessibility'] as String,
      kidFriendly: json['kidFriendly'] as bool,
      duration: json['duration'] as String,
      link: json['link'] as String,
      key: json['key'] as String,
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'activity': instance.activity,
      'availability': instance.availability,
      'type': instance.type,
      'participants': instance.participants,
      'price': instance.price,
      'accessibility': instance.accessibility,
      'kidFriendly': instance.kidFriendly,
      'duration': instance.duration,
      'link': instance.link,
      'key': instance.key,
    };
