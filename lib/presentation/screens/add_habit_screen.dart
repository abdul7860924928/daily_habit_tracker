import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_typography.dart';
import '../../domain/usecases/add_habit_usecase.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/habit_event.dart';
import '../bloc/habit_state.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pointsController = TextEditingController(text: '15');

  String _selectedCategory = 'Health';
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Health', 'icon': Icons.water_drop_rounded, 'color': Color(0xFF0EA5E9)},
    {'name': 'Fitness', 'icon': Icons.fitness_center_rounded, 'color': Color(0xFFF97316)},
    {'name': 'Learning', 'icon': Icons.menu_book_rounded, 'color': Color(0xFF8B5CF6)},
    {'name': 'Mindfulness', 'icon': Icons.spa_rounded, 'color': Color(0xFF10B981)},
    {'name': 'Productivity', 'icon': Icons.bolt_rounded, 'color': Color(0xFFEAB308)},
  ];

  final List<int> _quickPoints = [5, 10, 15, 20, 25, 50];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final points = int.tryParse(_pointsController.text.trim()) ?? 10;
      context.read<HabitBloc>().add(
            HabitAdded(
              AddHabitParams(
                name: _nameController.text.trim(),
                description: _descriptionController.text.trim(),
                points: points,
                category: _selectedCategory,
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HabitBloc, HabitState>(
      listener: (context, state) {
        if (state is HabitLoaded) {
          if (state.habitAddedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.successMessage ?? 'Habit created successfully!',
                      ),
                    ),
                  ],
                ),
                backgroundColor: AppColors.emeraldPrimary,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
            context.pop();
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textDark, size: 20),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Create New Habit',
            style: AppTypography.titleLarge.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(AppDimens.p20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Selector
                  Text(
                    'Category',
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: AppDimens.p8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: _categories.map((cat) {
                        final isSelected = _selectedCategory == cat['name'];
                        final color = cat['color'] as Color;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedCategory = cat['name'] as String;
                              });
                            },
                            borderRadius:
                                BorderRadius.circular(AppDimens.radiusFull),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? color.withValues(alpha: 0.15)
                                    : Colors.white,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.radiusFull),
                                border: Border.all(
                                  color: isSelected ? color : AppColors.borderLight,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    cat['icon'] as IconData,
                                    size: 16,
                                    color: isSelected ? color : AppColors.textMuted,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    cat['name'] as String,
                                    style: AppTypography.bodySmall.copyWith(
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? AppColors.textDark
                                          : AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: AppDimens.p24),

                  // Habit Name Input
                  Text(
                    'Habit Name *',
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: AppDimens.p8),
                  TextFormField(
                    controller: _nameController,
                    style: AppTypography.bodyLarge,
                    decoration: InputDecoration(
                      hintText: 'e.g. Drink 2L water, Read 20 pages',
                      hintStyle: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textLight,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.edit_note_rounded,
                        color: AppColors.emeraldPrimary,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.p16,
                        vertical: AppDimens.p16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusMedium),
                        borderSide: const BorderSide(color: AppColors.borderLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusMedium),
                        borderSide: const BorderSide(
                          color: AppColors.emeraldPrimary,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusMedium),
                        borderSide: const BorderSide(color: AppColors.error),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusMedium),
                        borderSide: const BorderSide(
                          color: AppColors.error,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please provide a habit name';
                      }
                      if (val.trim().length < 2) {
                        return 'Habit name is too short';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppDimens.p20),

                  // Description Input
                  Text(
                    'Description / Motivation',
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: AppDimens.p8),
                  TextFormField(
                    controller: _descriptionController,
                    style: AppTypography.bodyLarge,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Why is this habit important to you?',
                      hintStyle: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textLight,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.all(AppDimens.p16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusMedium),
                        borderSide: const BorderSide(color: AppColors.borderLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusMedium),
                        borderSide: const BorderSide(
                          color: AppColors.emeraldPrimary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimens.p24),

                  // Point Value Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Points Value *',
                        style: AppTypography.titleSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        'Earned upon daily completion',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.p8),

                  // Quick point presets
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _quickPoints.map((pts) {
                      final isSelected =
                          _pointsController.text.trim() == pts.toString();
                      return ChoiceChip(
                        label: Text('+$pts pts'),
                        selected: isSelected,
                        selectedColor:
                            AppColors.emeraldPrimary.withValues(alpha: 0.15),
                        backgroundColor: Colors.white,
                        labelStyle: AppTypography.bodySmall.copyWith(
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? AppColors.emeraldPrimary
                              : AppColors.textDark,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.emeraldPrimary
                              : AppColors.borderLight,
                          width: isSelected ? 2 : 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimens.radiusFull),
                        ),
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _pointsController.text = pts.toString();
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppDimens.p12),

                  // Custom Points Input
                  TextFormField(
                    controller: _pointsController,
                    keyboardType: TextInputType.number,
                    style: AppTypography.bodyLarge,
                    decoration: InputDecoration(
                      labelText: 'Custom Points',
                      hintText: 'e.g. 15',
                      prefixIcon: const Icon(
                        Icons.bolt_rounded,
                        color: AppColors.gold,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.p16,
                        vertical: AppDimens.p16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusMedium),
                        borderSide: const BorderSide(color: AppColors.borderLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusMedium),
                        borderSide: const BorderSide(
                          color: AppColors.emeraldPrimary,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusMedium),
                        borderSide: const BorderSide(color: AppColors.error),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Points value is required';
                      }
                      final parsed = int.tryParse(val.trim());
                      if (parsed == null || parsed <= 0) {
                        return 'Points must be a positive number';
                      }
                      return null;
                    },
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: AppDimens.p32),

                  // Submit Button
                  BlocBuilder<HabitBloc, HabitState>(
                    builder: (context, state) {
                      final isSubmitting =
                          state is HabitLoaded && state.isSubmitting;

                      return SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: isSubmitting ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.emeraldPrimary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimens.radiusMedium),
                            ),
                            elevation: 4,
                            shadowColor:
                                AppColors.emeraldPrimary.withValues(alpha: 0.4),
                          ),
                          child: isSubmitting
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add_task_rounded),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Save Habit',
                                      style: AppTypography.labelLarge.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
