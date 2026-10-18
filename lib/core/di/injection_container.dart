import 'package:get_it/get_it.dart';
import '../../data/datasources/habit_remote_data_source.dart';
import '../../data/repositories/habit_repository_impl.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../domain/usecases/add_habit_usecase.dart';
import '../../domain/usecases/delete_habit_usecase.dart';
import '../../domain/usecases/get_habits_stream_usecase.dart';
import '../../domain/usecases/toggle_habit_usecase.dart';
import '../../presentation/bloc/habit_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // 1. Data Sources
  sl.registerLazySingleton<HabitRemoteDataSource>(
    () => HabitRemoteDataSourceImpl(),
  );

  // 2. Repository
  sl.registerLazySingleton<HabitRepository>(
    () => HabitRepositoryImpl(remoteDataSource: sl()),
  );

  // 3. Use Cases
  sl.registerLazySingleton(() => GetHabitsStreamUseCase(sl()));
  sl.registerLazySingleton(() => AddHabitUseCase(sl()));
  sl.registerLazySingleton(() => ToggleHabitUseCase(sl()));
  sl.registerLazySingleton(() => DeleteHabitUseCase(sl()));

  // 4. Presentation BLoC
  sl.registerFactory(
    () => HabitBloc(
      getHabitsStreamUseCase: sl(),
      addHabitUseCase: sl(),
      toggleHabitUseCase: sl(),
      deleteHabitUseCase: sl(),
    ),
  );
}
