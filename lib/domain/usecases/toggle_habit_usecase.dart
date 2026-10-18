import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../../core/utils/date_utils.dart';
import '../repositories/habit_repository.dart';

class ToggleHabitParams {
  final String habitId;
  final String? dateKey; // If null, defaults to today's date

  ToggleHabitParams({
    required this.habitId,
    this.dateKey,
  });
}

class ToggleHabitUseCase implements UseCase<Unit, ToggleHabitParams> {
  final HabitRepository repository;

  ToggleHabitUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ToggleHabitParams params) async {
    if (params.habitId.isEmpty) {
      return const Left(ValidationFailure('Invalid habit identifier.'));
    }

    final targetDate = params.dateKey ?? HabitDateUtils.todayKey;

    return repository.toggleHabitStatus(
      habitId: params.habitId,
      dateKey: targetDate,
    );
  }
}
