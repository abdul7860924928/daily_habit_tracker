import 'package:flutter/foundation.dart';
import '../../core/utils/date_utils.dart';
import 'streak_summary.dart';

@immutable
class Habit {
  final String id;
  final String name;
  final String description;
  final int points;
  final List<String> completedDates; // List of 'yyyy-MM-dd'
  final DateTime createdAt;
  final String category; // e.g., 'Health', 'Fitness', 'Learning', 'Productivity', 'Mindfulness'

  const Habit({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.completedDates,
    required this.createdAt,
    this.category = 'General',
  });

  /// True if habit was marked done today
  bool get isCompletedToday => HabitDateUtils.isCompletedToday(completedDates);

  /// Current streak in days
  int get currentStreak => HabitDateUtils.calculateStreak(completedDates);

  /// Total points accumulated all-time by this habit
  int get totalPointsEarned => completedDates.length * points;

  /// 7-day streak breakdown for visualization
  List<DayStreakInfo> get last7DaysStreak =>
      HabitDateUtils.getLast7DaysStreak(completedDates);

  /// Freezed streak summary model
  StreakSummary get streakSummary => StreakSummary(
        currentStreak: currentStreak,
        bestStreak: currentStreak,
        totalCompletedDays: completedDates.length,
        completionRate: last7DaysStreak.where((d) => d.isCompleted).length / 7.0,
      );

  Habit copyWith({
    String? id,
    String? name,
    String? description,
    int? points,
    List<String>? completedDates,
    DateTime? createdAt,
    String? category,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      points: points ?? this.points,
      completedDates: completedDates ?? this.completedDates,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Habit &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          points == other.points &&
          listEquals(completedDates, other.completedDates) &&
          category == other.category;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      points.hashCode ^
      completedDates.hashCode ^
      category.hashCode;
}
