import 'package:daily_habit_tracker/core/utils/date_utils.dart';
import 'package:daily_habit_tracker/domain/entities/habit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Habit & Streak Domain Unit Tests', () {
    test('Habit calculations for streak and completion', () {
      final todayStr = HabitDateUtils.todayKey;
      final now = DateTime.now();
      final yesterday = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));
      final yesterdayStr = HabitDateUtils.formatIso(yesterday);

      final habit = Habit(
        id: '1',
        name: 'Drink 2L Water',
        description: 'Hydration',
        points: 15,
        completedDates: [todayStr, yesterdayStr],
        createdAt: DateTime.now(),
      );

      expect(habit.isCompletedToday, true);
      expect(habit.currentStreak, 2);
      expect(habit.totalPointsEarned, 30);
      expect(habit.last7DaysStreak.length, 7);
    });

    test('Streak calculation returns 0 when no dates completed', () {
      final habit = Habit(
        id: '2',
        name: 'Exercise',
        description: 'Workout',
        points: 20,
        completedDates: const [],
        createdAt: DateTime.now(),
      );

      expect(habit.isCompletedToday, false);
      expect(habit.currentStreak, 0);
      expect(habit.totalPointsEarned, 0);
    });
  });
}
