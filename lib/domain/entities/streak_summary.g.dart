// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StreakSummary _$StreakSummaryFromJson(Map<String, dynamic> json) =>
    _StreakSummary(
      currentStreak: (json['currentStreak'] as num).toInt(),
      bestStreak: (json['bestStreak'] as num).toInt(),
      totalCompletedDays: (json['totalCompletedDays'] as num).toInt(),
      completionRate: (json['completionRate'] as num).toDouble(),
    );

Map<String, dynamic> _$StreakSummaryToJson(_StreakSummary instance) =>
    <String, dynamic>{
      'currentStreak': instance.currentStreak,
      'bestStreak': instance.bestStreak,
      'totalCompletedDays': instance.totalCompletedDays,
      'completionRate': instance.completionRate,
    };
