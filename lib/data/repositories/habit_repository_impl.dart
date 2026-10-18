import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habit_repository.dart';
import '../datasources/habit_remote_data_source.dart';
import '../models/habit_model.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitRemoteDataSource remoteDataSource;

  HabitRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Either<Failure, List<Habit>>> getHabitsStream() {
    try {
      return remoteDataSource
          .getHabitsStream()
          .map<Either<Failure, List<Habit>>>((models) {
        final List<Habit> habits = models.map((m) => m.toEntity()).toList();
        return Right(habits);
      }).handleError((error) {
        return Left(ServerFailure(error.toString()));
      });
    } catch (e) {
      return Stream.value(Left(ServerFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, Habit>> getHabitById(String id) async {
    try {
      final model = await remoteDataSource.getHabitById(id);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addHabit(Habit habit) async {
    try {
      final model = HabitModel.fromEntity(habit);
      await remoteDataSource.addHabit(model);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleHabitStatus({
    required String habitId,
    required String dateKey,
  }) async {
    try {
      await remoteDataSource.toggleHabitStatus(
        habitId: habitId,
        dateKey: dateKey,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteHabit(String habitId) async {
    try {
      await remoteDataSource.deleteHabit(habitId);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
