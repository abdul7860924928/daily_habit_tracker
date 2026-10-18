import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class GetHabitsStreamUseCase implements StreamUseCase<List<Habit>, NoParams> {
  final HabitRepository repository;

  GetHabitsStreamUseCase(this.repository);

  @override
  Stream<Either<Failure, List<Habit>>> call(NoParams params) {
    return repository.getHabitsStream();
  }
}
