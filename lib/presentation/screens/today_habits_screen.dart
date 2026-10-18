import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_typography.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';
import '../bloc/habit_state.dart';
import '../widgets/daily_progress_header.dart';
import '../widgets/habit_list_item.dart';

class TodayHabitsScreen extends StatelessWidget {
  const TodayHabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.p8),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
              ),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: AppDimens.p12),
            Text(
              'HabitPulse',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Add Habit',
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.emeraldLight.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: AppColors.emeraldPrimary,
                size: 22,
              ),
            ),
            onPressed: () => context.push('/add'),
          ),
          const SizedBox(width: AppDimens.p8),
        ],
      ),
      body: BlocConsumer<HabitBloc, HabitState>(
        listener: (context, state) {
          if (state is HabitLoaded && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HabitLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.emeraldPrimary),
              ),
            );
          }

          if (state is HabitError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.p24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      size: 48,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: AppDimens.p16),
                    Text(
                      'Oops, something went wrong',
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: AppDimens.p8),
                    Text(
                      state.message,
                      style: AppTypography.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimens.p16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.emeraldPrimary,
                      ),
                      onPressed: () {
                        context
                            .read<HabitBloc>()
                            .add(const LoadHabitsSubscriptionStarted());
                      },
                      child: const Text('Try Again', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is HabitLoaded) {
            final habits = state.habits;

            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                // Top Progress Card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.p16,
                      AppDimens.p8,
                      AppDimens.p16,
                      AppDimens.p16,
                    ),
                    child: DailyProgressHeader(
                      totalPointsEarned: state.totalPointsEarnedToday,
                      completedCount: state.completedCountToday,
                      totalHabits: state.totalHabitsCount,
                      progress: state.completionProgress,
                    ),
                  ),
                ),

                // Section Title: "Today's Habits"
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.p16,
                      vertical: AppDimens.p8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Today's Habits",
                              style: AppTypography.titleLarge.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.chipBackground,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.radiusFull),
                              ),
                              child: Text(
                                '${state.completedCountToday}/${habits.length}',
                                style: AppTypography.bodySmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.emeraldPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Tap card for details',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Habits List or Empty State
                if (habits.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimens.p32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppColors.emeraldLight.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.task_alt_rounded,
                                size: 40,
                                color: AppColors.emeraldPrimary,
                              ),
                            ),
                            const SizedBox(height: AppDimens.p20),
                            Text(
                              'No Habits Added Yet',
                              style: AppTypography.titleLarge,
                            ),
                            const SizedBox(height: AppDimens.p8),
                            Text(
                              'Start building consistency today. Add your first habit and start earning daily points!',
                              style: AppTypography.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppDimens.p24),
                            InkWell(
                              onTap: () => context.push('/add'),
                              borderRadius:
                                  BorderRadius.circular(AppDimens.radiusMedium),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimens.p24,
                                  vertical: AppDimens.p12,
                                ),
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius:
                                      BorderRadius.circular(AppDimens.radiusMedium),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.emeraldPrimary
                                          .withValues(alpha: 0.35),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.add_rounded,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Create First Habit',
                                      style: AppTypography.labelLarge.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.p16,
                      vertical: AppDimens.p8,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final habit = habits[index];
                          return HabitListItem(
                            habit: habit,
                            onTap: () => context.push('/detail/${habit.id}'),
                            onToggle: () {
                              context.read<HabitBloc>().add(
                                    HabitToggled(habitId: habit.id),
                                  );
                            },
                          );
                        },
                        childCount: habits.length,
                      ),
                    ),
                  ),

                // Bottom padding for FAB spacing
                const SliverToBoxAdapter(
                  child: SizedBox(height: 90),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add'),
        elevation: 4,
        highlightElevation: 8,
        backgroundColor: AppColors.emeraldPrimary,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'Add Habit',
          style: AppTypography.labelLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
