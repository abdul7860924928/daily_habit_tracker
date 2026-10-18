import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_summary.freezed.dart';
part 'streak_summary.g.dart';

@freezed
abstract class StreakSummary with _$StreakSummary {
  const factory StreakSummary({
    required int currentStreak,
    required int bestStreak,
    required int totalCompletedDays,
    required double completionRate,
  }) = _StreakSummary;

  factory StreakSummary.fromJson(Map<String, dynamic> json) =>
      _$StreakSummaryFromJson(json);
}
