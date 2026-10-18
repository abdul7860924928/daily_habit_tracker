import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/habit_repository.dart';

class DeleteHabitUseCase implements UseCase<Unit, String> {
  final HabitRepository repository;

  DeleteHabitUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String habitId) async {
    if (habitId.isEmpty) {
      return const Left(ValidationFailure('Invalid habit identifier.'));
    }
    return repository.deleteHabit(habitId);
  }
}
