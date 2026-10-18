import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/habit.dart';

class HabitModel extends Habit {
  const HabitModel({
    required super.id,
    required super.name,
    required super.description,
    required super.points,
    required super.completedDates,
    required super.createdAt,
    super.category = 'General',
  });

  /// Factory from Firestore Document Snapshot
  factory HabitModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return HabitModel.fromMap(data, id: doc.id);
  }

  /// Factory from generic Map
  factory HabitModel.fromMap(Map<String, dynamic> map, {String? id}) {
    DateTime parsedCreatedAt;
    if (map['createdAt'] is Timestamp) {
      parsedCreatedAt = (map['createdAt'] as Timestamp).toDate();
    } else if (map['createdAt'] is String) {
      parsedCreatedAt = DateTime.tryParse(map['createdAt']) ?? DateTime.now();
    } else {
      parsedCreatedAt = DateTime.now();
    }

    final rawCompleted = map['completedDates'];
    List<String> completedList = [];
    if (rawCompleted is List) {
      completedList = rawCompleted.map((e) => e.toString()).toList();
    }

    return HabitModel(
      id: id ?? map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      points: (map['points'] as num?)?.toInt() ?? 10,
      completedDates: completedList,
      createdAt: parsedCreatedAt,
      category: map['category'] ?? 'General',
    );
  }

  /// Convert to Firestore Map
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'points': points,
      'completedDates': completedDates,
      'createdAt': Timestamp.fromDate(createdAt),
      'category': category,
    };
  }

  /// Convert to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'points': points,
      'completedDates': completedDates,
      'createdAt': createdAt.toIso8601String(),
      'category': category,
    };
  }

  /// Create HabitModel from domain Habit entity
  factory HabitModel.fromEntity(Habit habit) {
    return HabitModel(
      id: habit.id,
      name: habit.name,
      description: habit.description,
      points: habit.points,
      completedDates: habit.completedDates,
      createdAt: habit.createdAt,
      category: habit.category,
    );
  }

  /// Convert back to pure domain Habit entity
  Habit toEntity() {
    return Habit(
      id: id,
      name: name,
      description: description,
      points: points,
      completedDates: completedDates,
      createdAt: createdAt,
      category: category,
    );
  }
}
