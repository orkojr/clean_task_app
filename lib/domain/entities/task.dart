import 'package:clean_task_app/domain/entities/task_priority.dart';

class Task {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime date;
  final TaskPriority priority; // Changé de int à TaskPriority

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.date,
    required this.priority, // Maintenant de type TaskPriority
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? date,
    TaskPriority? priority, // Mise à jour ici aussi
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      priority: priority ?? this.priority,
    );
  }
}