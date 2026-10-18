import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/date_utils.dart';

class StreakCalendarBar extends StatelessWidget {
  final List<DayStreakInfo> streakDays;
  final Function(DayStreakInfo)? onDayTap;

  const StreakCalendarBar({
    super.key,
    required this.streakDays,
    this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.p12,
        vertical: AppDimens.p16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.p4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '7-Day Streak History',
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Last 7 Days',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.p16),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: streakDays.map((day) {
                return _DayStreakItem(
                  info: day,
                  onTap: onDayTap != null ? () => onDayTap!(day) : null,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayStreakItem extends StatelessWidget {
  final DayStreakInfo info;
  final VoidCallback? onTap;

  const _DayStreakItem({
    required this.info,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = info.isCompleted;
    final isToday = info.isToday;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.p8,
          vertical: AppDimens.p8,
        ),
        decoration: BoxDecoration(
          color: isToday
              ? (isDone
                  ? AppColors.emeraldLight.withValues(alpha: 0.12)
                  : AppColors.chipBackground)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          border: Border.all(
            color: isToday
                ? AppColors.emeraldPrimary
                : Colors.transparent,
            width: isToday ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            // Day initial / name
            Text(
              info.dayName,
              style: AppTypography.bodySmall.copyWith(
                fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                color: isToday ? AppColors.emeraldPrimary : AppColors.textMuted,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 6),
            // Status Icon Circle
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isDone ? AppColors.primaryGradient : null,
                color: isDone ? null : AppColors.chipBackground,
                boxShadow: isDone
                    ? [
                        BoxShadow(
                          color: AppColors.emeraldPrimary.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
                border: isDone
                    ? null
                    : Border.all(
                        color: AppColors.borderLight,
                        width: 1.5,
                      ),
              ),
              child: Center(
                child: isDone
                    ? const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 18,
                      )
                    : Text(
                        info.dayNumber,
                        style: AppTypography.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isToday
                              ? AppColors.textDark
                              : AppColors.textMuted,
                          fontSize: 11,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 4),
            // Sub-indicator
            Text(
              isToday ? 'Today' : info.dayNumber,
              style: AppTypography.bodySmall.copyWith(
                fontSize: 9,
                fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                color: isToday ? AppColors.emeraldPrimary : AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
