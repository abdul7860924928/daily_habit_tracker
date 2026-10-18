import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app_colors.dart';
import 'core/di/injection_container.dart';
import 'firebase_options.dart';
import 'presentation/bloc/habit_bloc.dart';
import 'presentation/bloc/habit_event.dart';
import 'presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (supports Firestore remote backend)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('[Firebase] Successfully initialized Firebase');
  } catch (e) {
    debugPrint('[Firebase] Notice: $e');
  }

  // Initialize Dependency Injection
  await initDependencies();

  runApp(const DailyHabitTrackerApp());
}

class DailyHabitTrackerApp extends StatelessWidget {
  const DailyHabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HabitBloc>(
      create: (context) => sl<HabitBloc>()..add(const LoadHabitsSubscriptionStarted()),
      child: MaterialApp.router(
        title: 'Daily Habit Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.emeraldPrimary,
            primary: AppColors.emeraldPrimary,
            secondary: AppColors.mintAccent,
            surface: AppColors.backgroundLight,
          ),
          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            iconTheme: IconThemeData(color: AppColors.textDark),
          ),
          cardTheme: const CardThemeData(
            color: Colors.white,
            elevation: 0,
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
