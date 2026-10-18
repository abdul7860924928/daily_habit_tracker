import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/usecases/add_habit_usecase.dart';
import '../../domain/usecases/delete_habit_usecase.dart';
import '../../domain/usecases/get_habits_stream_usecase.dart';
import '../../domain/usecases/toggle_habit_usecase.dart';
import 'habit_event.dart';
import 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final GetHabitsStreamUseCase getHabitsStreamUseCase;
  final AddHabitUseCase addHabitUseCase;
  final ToggleHabitUseCase toggleHabitUseCase;
  final DeleteHabitUseCase deleteHabitUseCase;

  StreamSubscription? _habitsSubscription;

  HabitBloc({
    required this.getHabitsStreamUseCase,
    required this.addHabitUseCase,
    required this.toggleHabitUseCase,
    required this.deleteHabitUseCase,
  }) : super(const HabitInitial()) {
    on<LoadHabitsSubscriptionStarted>(_onLoadHabitsSubscriptionStarted);
    on<HabitsUpdated>(_onHabitsUpdated);
    on<HabitsStreamError>(_onHabitsStreamError);
    on<HabitAdded>(_onHabitAdded);
    on<HabitToggled>(_onHabitToggled);
    on<HabitDeleted>(_onHabitDeleted);
  }

  Future<void> _onLoadHabitsSubscriptionStarted(
    LoadHabitsSubscriptionStarted event,
    Emitter<HabitState> emit,
  ) async {
    emit(const HabitLoading());
    await _habitsSubscription?.cancel();

    _habitsSubscription = getHabitsStreamUseCase(const NoParams()).listen(
      (result) {
        result.fold(
          (failure) => add(HabitsStreamError(failure.message)),
          (habits) => add(HabitsUpdated(habits)),
        );
      },
      onError: (err) {
        add(HabitsStreamError(err.toString()));
      },
    );
  }

  void _onHabitsUpdated(HabitsUpdated event, Emitter<HabitState> emit) {
    if (state is HabitLoaded) {
      final current = state as HabitLoaded;
      emit(current.copyWith(
        habits: event.habits,
        isSubmitting: false,
        habitAddedSuccess: false,
      ));
    } else {
      emit(HabitLoaded(habits: event.habits));
    }
  }

  void _onHabitsStreamError(HabitsStreamError event, Emitter<HabitState> emit) {
    emit(HabitError(event.message));
  }

  Future<void> _onHabitAdded(
    HabitAdded event,
    Emitter<HabitState> emit,
  ) async {
    if (state is HabitLoaded) {
      emit((state as HabitLoaded).copyWith(isSubmitting: true, errorMessage: null));
    }

    final result = await addHabitUseCase(event.params);

    result.fold(
      (failure) {
        if (state is HabitLoaded) {
          emit((state as HabitLoaded).copyWith(
            isSubmitting: false,
            errorMessage: failure.message,
          ));
        } else {
          emit(HabitError(failure.message));
        }
      },
      (_) {
        if (state is HabitLoaded) {
          emit((state as HabitLoaded).copyWith(
            isSubmitting: false,
            habitAddedSuccess: true,
            successMessage: 'Habit "${event.params.name}" created successfully! 🌟',
          ));
        }
      },
    );
  }

  Future<void> _onHabitToggled(
    HabitToggled event,
    Emitter<HabitState> emit,
  ) async {
    final result = await toggleHabitUseCase(
      ToggleHabitParams(
        habitId: event.habitId,
        dateKey: event.dateKey,
      ),
    );

    result.fold(
      (failure) {
        if (state is HabitLoaded) {
          emit((state as HabitLoaded).copyWith(errorMessage: failure.message));
        }
      },
      (_) {
        // Stream subscription will automatically deliver updated habits list!
      },
    );
  }

  Future<void> _onHabitDeleted(
    HabitDeleted event,
    Emitter<HabitState> emit,
  ) async {
    final result = await deleteHabitUseCase(event.habitId);
    result.fold(
      (failure) {
        if (state is HabitLoaded) {
          emit((state as HabitLoaded).copyWith(errorMessage: failure.message));
        }
      },
      (_) {
        // Updated via stream
      },
    );
  }

  @override
  Future<void> close() {
    _habitsSubscription?.cancel();
    return super.close();
  }
}
