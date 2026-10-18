import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_typography.dart';
import '../../domain/entities/habit.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';
import '../bloc/habit_state.dart';
import '../widgets/streak_calendar_bar.dart';

class HabitDetailScreen extends StatelessWidget {
  final String habitId;

  const HabitDetailScreen({
    super.key,
    required this.habitId,
  });

  void _showDeleteDialog(BuildContext context, Habit habit) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
        ),
        title: Text('Delete Habit?', style: AppTypography.titleLarge),
        content: Text(
          'Are you sure you want to remove "${habit.name}"? All streak progress and points recorded for this habit will be deleted.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: AppTypography.titleSmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<HabitBloc>().add(HabitDeleted(habit.id));
              context.pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitBloc, HabitState>(
      builder: (context, state) {
        if (state is! HabitLoaded) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.emeraldPrimary),
              ),
            ),
          );
        }

        final habit = state.habits.where((h) => h.id == habitId).firstOrNull;

        if (habit == null) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => context.pop(),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off_rounded, size: 64, color: AppColors.textLight),
                  const SizedBox(height: 16),
                  Text('Habit not found', style: AppTypography.titleLarge),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        }

        final isDoneToday = habit.isCompletedToday;
        final streak7 = habit.last7DaysStreak;
        final completedInLast7 = streak7.where((d) => d.isCompleted).length;
        final completionRateLast7 = (completedInLast7 / 7 * 100).toInt();

        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.textDark,
                size: 20,
              ),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Habit Detail',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            actions: [
              IconButton(
                tooltip: 'Delete Habit',
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.error,
                ),
                onPressed: () => _showDeleteDialog(context, habit),
              ),
              const SizedBox(width: AppDimens.p8),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(AppDimens.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Hero Card: Streak & Name
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppDimens.p24),
                  decoration: BoxDecoration(
                    gradient: AppColors.streakCardGradient,
                    borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.forestDark.withValues(alpha: 0.3),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Tag & Points Tag
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius:
                                  BorderRadius.circular(AppDimens.radiusFull),
                            ),
                            child: Text(
                              habit.category.toUpperCase(),
                              style: AppTypography.bodySmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withValues(alpha: 0.25),
                              borderRadius:
                                  BorderRadius.circular(AppDimens.radiusFull),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.bolt_rounded,
                                  size: 14,
                                  color: AppColors.gold,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${habit.points} Points / Day',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.p16),

                      // Habit Title
                      Text(
                        habit.name,
                        style: AppTypography.displayMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (habit.description.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          habit.description,
                          style: AppTypography.bodyMedium.copyWith(
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                      const SizedBox(height: AppDimens.p20),

                      // Streak Counter Display
                      Container(
                        padding: const EdgeInsets.all(AppDimens.p16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius:
                              BorderRadius.circular(AppDimens.radiusMedium),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('🔥', style: TextStyle(fontSize: 22)),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${habit.currentStreak}',
                                      style: AppTypography.displayMedium.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Day Streak',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 36,
                              width: 1,
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            Column(
                              children: [
                                Text(
                                  '$completionRateLast7%',
                                  style: AppTypography.displayMedium.copyWith(
                                    color: AppColors.mintAccent,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  '7-Day Consistency',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimens.p24),

                // Screen 3 Requirement: 7-Day Streak Visualization
                StreakCalendarBar(
                  streakDays: streak7,
                  onDayTap: (dayInfo) {
                    HapticFeedback.lightImpact();
                    context.read<HabitBloc>().add(
                          HabitToggled(
                            habitId: habit.id,
                            dateKey: dayInfo.dateKey,
                          ),
                        );
                  },
                ),
                const SizedBox(height: AppDimens.p24),

                // Statistics Grid: All-Time Days & Total Points
                Text(
                  'Lifetime Stats',
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppDimens.p12),
                Row(
                  children: [
                    // Total Days Completed Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(AppDimens.p16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(AppDimens.radiusMedium),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.calendar_month_rounded,
                              color: AppColors.emeraldPrimary,
                              size: 24,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${habit.completedDates.length}',
                              style: AppTypography.titleLarge.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Total Days Completed',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimens.p12),

                    // Total Points Earned Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(AppDimens.p16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(AppDimens.radiusMedium),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.stars_rounded,
                              color: AppColors.gold,
                              size: 24,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${habit.totalPointsEarned}',
                              style: AppTypography.titleLarge.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Total Points Earned',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.p32),

                // Screen 3 Requirement: Mark Today as Done / Undone Large Action Button
                InkWell(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    context.read<HabitBloc>().add(
                          HabitToggled(habitId: habit.id),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isDoneToday
                              ? 'Marked habit as undone (-${habit.points} pts)'
                              : 'Awesome! Marked as done (+${habit.points} pts earned! 🎉)',
                        ),
                        backgroundColor: isDoneToday
                            ? AppColors.textDark
                            : AppColors.emeraldPrimary,
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      gradient: isDoneToday
                          ? null
                          : AppColors.primaryGradient,
                      color: isDoneToday
                          ? AppColors.chipBackground
                          : null,
                      borderRadius:
                          BorderRadius.circular(AppDimens.radiusMedium),
                      border: Border.all(
                        color: isDoneToday
                            ? AppColors.emeraldPrimary
                            : Colors.transparent,
                        width: 1.5,
                      ),
                      boxShadow: isDoneToday
                          ? null
                          : [
                              BoxShadow(
                                color: AppColors.emeraldPrimary
                                    .withValues(alpha: 0.35),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isDoneToday
                              ? Icons.check_circle_rounded
                              : Icons.check_circle_outline_rounded,
                          color: isDoneToday
                              ? AppColors.emeraldPrimary
                              : Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          isDoneToday
                              ? 'Done Today! Tap to Undo'
                              : 'Mark Today as Done (+${habit.points} pts)',
                          style: AppTypography.labelLarge.copyWith(
                            color: isDoneToday
                                ? AppColors.emeraldPrimary
                                : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
