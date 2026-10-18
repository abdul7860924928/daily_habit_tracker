import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/date_utils.dart';

class DailyProgressHeader extends StatelessWidget {
  final int totalPointsEarned;
  final int completedCount;
  final int totalHabits;
  final double progress;

  const DailyProgressHeader({
    super.key,
    required this.totalPointsEarned,
    required this.completedCount,
    required this.totalHabits,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final percentInt = (progress * 100).toInt();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.p20),
      decoration: BoxDecoration(
        gradient: AppColors.heroCardGradient,
        borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.emeraldPrimary.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background decorative glow circle
          Positioned(
            right: -25,
            top: -25,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date and greeting
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        HabitDateUtils.formattedToday,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.mintHighlight.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Today's Overview",
                        style: AppTypography.titleLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  // Points earned badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.p12,
                      vertical: AppDimens.p8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.stars_rounded,
                          color: AppColors.gold,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$totalPointsEarned pts',
                          style: AppTypography.titleSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.p20),

              // Progress Row with Circular Progress Ring & Stats
              Row(
                children: [
                  // Circular Progress Indicator
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: totalHabits > 0 ? progress : 0.0,
                          strokeWidth: 6,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.mintAccent,
                          ),
                          strokeCap: StrokeCap.round,
                        ),
                        Text(
                          '$percentInt%',
                          style: AppTypography.titleSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppDimens.p16),
                  // Progress Text description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          totalHabits == 0
                              ? 'No habits created yet'
                              : completedCount == totalHabits
                                  ? 'All habits completed! 🎉'
                                  : '$completedCount of $totalHabits habits done',
                          style: AppTypography.titleMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          totalHabits == 0
                              ? 'Tap + below to build your first habit.'
                              : completedCount == totalHabits
                                  ? 'Incredible dedication! You crushed today.'
                                  : 'Keep moving forward, every rep counts.',
                          style: AppTypography.bodySmall.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
