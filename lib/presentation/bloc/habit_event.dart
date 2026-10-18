import 'package:flutter/foundation.dart';
import '../../domain/entities/habit.dart';
import '../../domain/usecases/add_habit_usecase.dart';

@immutable
abstract class HabitEvent {
  const HabitEvent();
}

class LoadHabitsSubscriptionStarted extends HabitEvent {
  const LoadHabitsSubscriptionStarted();
}

class HabitsUpdated extends HabitEvent {
  final List<Habit> habits;
  const HabitsUpdated(this.habits);
}

class HabitsStreamError extends HabitEvent {
  final String message;
  const HabitsStreamError(this.message);
}

class HabitAdded extends HabitEvent {
  final AddHabitParams params;
  const HabitAdded(this.params);
}

class HabitToggled extends HabitEvent {
  final String habitId;
  final String? dateKey; // null for today
  const HabitToggled({required this.habitId, this.dateKey});
}

class HabitDeleted extends HabitEvent {
  final String habitId;
  const HabitDeleted(this.habitId);
}
