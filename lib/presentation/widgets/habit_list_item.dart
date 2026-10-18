import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_typography.dart';
import '../../domain/entities/habit.dart';

class HabitListItem extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  const HabitListItem({
    super.key,
    required this.habit,
    required this.onTap,
    required this.onToggle,
  });

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'health':
        return Icons.water_drop_rounded;
      case 'fitness':
        return Icons.fitness_center_rounded;
      case 'learning':
        return Icons.menu_book_rounded;
      case 'mindfulness':
        return Icons.spa_rounded;
      case 'productivity':
        return Icons.bolt_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'health':
        return const Color(0xFF0EA5E9);
      case 'fitness':
        return const Color(0xFFF97316);
      case 'learning':
        return const Color(0xFF8B5CF6);
      case 'mindfulness':
        return const Color(0xFF10B981);
      case 'productivity':
        return const Color(0xFFEAB308);
      default:
        return AppColors.emeraldPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDone = habit.isCompletedToday;
    final catColor = _getCategoryColor(habit.category);

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.p12),
      decoration: BoxDecoration(
        color: isDone ? const Color(0xFFF0FDF4) : Colors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
        border: Border.all(
          color: isDone
              ? AppColors.emeraldLight.withValues(alpha: 0.4)
              : AppColors.borderLight,
          width: isDone ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDone
                ? AppColors.emeraldPrimary.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.p16),
            child: Row(
              children: [
                // Category Icon Chip
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: catColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
                  ),
                  child: Icon(
                    _getCategoryIcon(habit.category),
                    color: catColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: AppDimens.p12),

                // Habit Title, Category, Streak
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              habit.name,
                              style: AppTypography.titleMedium.copyWith(
                                decoration: isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: isDone
                                    ? AppColors.textMuted
                                    : AppColors.textDark,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          // Points Pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isDone
                                  ? AppColors.emeraldPrimary.withValues(alpha: 0.15)
                                  : AppColors.chipBackground,
                              borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.bolt_rounded,
                                  size: 13,
                                  color: isDone
                                      ? AppColors.emeraldPrimary
                                      : AppColors.gold,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  '${habit.points} pts',
                                  style: AppTypography.bodySmall.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    color: isDone
                                        ? AppColors.emeraldPrimary
                                        : AppColors.textDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Streak Pill (if streak > 0)
                          if (habit.currentStreak > 0)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('🔥', style: TextStyle(fontSize: 11)),
                                const SizedBox(width: 2),
                                Text(
                                  '${habit.currentStreak}d streak',
                                  style: AppTypography.bodySmall.copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.warning,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDimens.p12),

                // Interactive Done/Undone Checkbox Toggle
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onToggle();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isDone ? AppColors.primaryGradient : null,
                      color: isDone ? null : Colors.transparent,
                      border: Border.all(
                        color: isDone
                            ? AppColors.emeraldPrimary
                            : AppColors.borderLight,
                        width: isDone ? 2 : 2,
                      ),
                      boxShadow: isDone
                          ? [
                              BoxShadow(
                                color: AppColors.emeraldPrimary.withValues(alpha: 0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: AnimatedScale(
                        scale: isDone ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
