import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/add_habit_screen.dart';
import '../screens/habit_detail_screen.dart';
import '../screens/today_habits_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'todayHabits',
        builder: (context, state) => const TodayHabitsScreen(),
      ),
      GoRoute(
        path: '/add',
        name: 'addHabit',
        builder: (context, state) => const AddHabitScreen(),
      ),
      GoRoute(
        path: '/detail/:id',
        name: 'habitDetail',
        builder: (context, state) {
          final habitId = state.pathParameters['id'] ?? '';
          return HabitDetailScreen(habitId: habitId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}
