import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/habit.dart';

abstract class HabitRepository {
  /// Stream of all habits updated in real-time from Firestore
  Stream<Either<Failure, List<Habit>>> getHabitsStream();

  /// Fetch a single habit by its unique ID
  Future<Either<Failure, Habit>> getHabitById(String id);

  /// Create a new habit
  Future<Either<Failure, Unit>> addHabit(Habit habit);

  /// Toggle habit completion status for a given date ('yyyy-MM-dd')
  Future<Either<Failure, Unit>> toggleHabitStatus({
    required String habitId,
    required String dateKey,
  });

  /// Delete a habit
  Future<Either<Failure, Unit>> deleteHabit(String habitId);
}
