import 'package:flutter/foundation.dart';
import '../../domain/entities/habit.dart';

@immutable
abstract class HabitState {
  const HabitState();
}

class HabitInitial extends HabitState {
  const HabitInitial();
}

class HabitLoading extends HabitState {
  const HabitLoading();
}

class HabitLoaded extends HabitState {
  final List<Habit> habits;
  final bool isSubmitting;
  final String? errorMessage;
  final String? successMessage;
  final bool habitAddedSuccess;

  const HabitLoaded({
    required this.habits,
    this.isSubmitting = false,
    this.errorMessage,
    this.successMessage,
    this.habitAddedSuccess = false,
  });

  /// Total points earned by the user today
  int get totalPointsEarnedToday {
    int total = 0;
    for (final habit in habits) {
      if (habit.isCompletedToday) {
        total += habit.points;
      }
    }
    return total;
  }

  /// Total possible points if all habits are completed today
  int get totalPossiblePointsToday {
    int total = 0;
    for (final habit in habits) {
      total += habit.points;
    }
    return total;
  }

  /// Number of habits completed today
  int get completedCountToday {
    return habits.where((h) => h.isCompletedToday).length;
  }

  /// Total number of habits
  int get totalHabitsCount => habits.length;

  /// Completion ratio (0.0 to 1.0)
  double get completionProgress {
    if (habits.isEmpty) return 0.0;
    return completedCountToday / habits.length;
  }

  HabitLoaded copyWith({
    List<Habit>? habits,
    bool? isSubmitting,
    String? errorMessage,
    String? successMessage,
    bool? habitAddedSuccess,
  }) {
    return HabitLoaded(
      habits: habits ?? this.habits,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      successMessage: successMessage,
      habitAddedSuccess: habitAddedSuccess ?? false,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitLoaded &&
          runtimeType == other.runtimeType &&
          listEquals(habits, other.habits) &&
          isSubmitting == other.isSubmitting &&
          errorMessage == other.errorMessage &&
          successMessage == other.successMessage &&
          habitAddedSuccess == other.habitAddedSuccess;

  @override
  int get hashCode =>
      habits.hashCode ^
      isSubmitting.hashCode ^
      errorMessage.hashCode ^
      successMessage.hashCode ^
      habitAddedSuccess.hashCode;
}

class HabitError extends HabitState {
  final String message;
  const HabitError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
