import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class AddHabitParams {
  final String name;
  final String description;
  final int points;
  final String category;

  AddHabitParams({
    required this.name,
    required this.description,
    required this.points,
    this.category = 'General',
  });
}

class AddHabitUseCase implements UseCase<Unit, AddHabitParams> {
  final HabitRepository repository;

  AddHabitUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(AddHabitParams params) async {
    final trimmedName = params.name.trim();
    if (trimmedName.isEmpty) {
      return const Left(ValidationFailure('Habit name cannot be empty.'));
    }
    if (params.points <= 0) {
      return const Left(ValidationFailure('Points value must be greater than 0.'));
    }

    final newHabit = Habit(
      id: '', // Will be assigned by Firestore or repository
      name: trimmedName,
      description: params.description.trim(),
      points: params.points,
      completedDates: const [],
      createdAt: DateTime.now(),
      category: params.category,
    );

    return repository.addHabit(newHabit);
  }
}
