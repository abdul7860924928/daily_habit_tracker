import 'package:intl/intl.dart';

class DayStreakInfo {
  final DateTime date;
  final String dateKey; // yyyy-MM-dd
  final String dayName; // Mon, Tue, etc.
  final String dayNumber; // 1, 2, ... 31
  final bool isToday;
  final bool isCompleted;

  DayStreakInfo({
    required this.date,
    required this.dateKey,
    required this.dayName,
    required this.dayNumber,
    required this.isToday,
    required this.isCompleted,
  });
}

class HabitDateUtils {
  static final DateFormat _isoFormat = DateFormat('yyyy-MM-dd');

  /// Formats date to 'yyyy-MM-dd'
  static String formatIso(DateTime date) {
    return _isoFormat.format(date);
  }

  /// Today's key in 'yyyy-MM-dd'
  static String get todayKey => formatIso(DateTime.now());

  /// Checks if habit is completed today
  static bool isCompletedToday(List<String> completedDates) {
    return completedDates.contains(todayKey);
  }

  /// Calculates current consecutive day streak
  static int calculateStreak(List<String> completedDates) {
    if (completedDates.isEmpty) return 0;

    final Set<String> datesSet = completedDates.toSet();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final todayStr = formatIso(today);
    final yesterday = today.subtract(const Duration(days: 1));
    final yesterdayStr = formatIso(yesterday);

    int streak = 0;
    DateTime checkDate;

    if (datesSet.contains(todayStr)) {
      streak = 1;
      checkDate = yesterday;
    } else if (datesSet.contains(yesterdayStr)) {
      // Habit not completed today yet, but streak preserved from yesterday
      streak = 1;
      checkDate = yesterday.subtract(const Duration(days: 1));
    } else {
      return 0;
    }

    while (datesSet.contains(formatIso(checkDate))) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    return streak;
  }

  /// Returns 7-day streak info list for the last 7 days (6 days ago through today)
  static List<DayStreakInfo> getLast7DaysStreak(List<String> completedDates) {
    final Set<String> datesSet = completedDates.toSet();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final todayStr = formatIso(today);

    final List<DayStreakInfo> list = [];

    for (int i = 6; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final dateKey = formatIso(date);
      final dayName = DateFormat('E').format(date); // Mon, Tue
      final dayNumber = DateFormat('d').format(date); // 18
      final isToday = dateKey == todayStr;
      final isCompleted = datesSet.contains(dateKey);

      list.add(DayStreakInfo(
        date: date,
        dateKey: dateKey,
        dayName: dayName,
        dayNumber: dayNumber,
        isToday: isToday,
        isCompleted: isCompleted,
      ));
    }

    return list;
  }

  /// Friendly date formatted for today's header (e.g. "Sunday, Oct 18")
  static String get formattedToday {
    return DateFormat('EEEE, MMM d').format(DateTime.now());
  }
}
