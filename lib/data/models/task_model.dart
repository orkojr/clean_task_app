import 'package:clean_task_app/domain/entities/task.dart';
import 'package:clean_task_app/domain/entities/task_priority.dart';

class TaskModel {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime date;
  final TaskPriority priority;

  const TaskModel({
    this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    required this.date,
    this.priority = TaskPriority.medium,
  });

  // Constructeur de copie avec pattern 'copyWith'
  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? date,
    TaskPriority? priority,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      priority: priority ?? this.priority,
    );
  }

  // Conversion vers Map optimisée
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted ? 1 : 0, // Stocké comme entier pour SQLite
      'date': date.toIso8601String(), // Format ISO 8601
      'priority': priority.value,
    };
  }

  // Constructeur fromMap avec validation
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    try {
      return TaskModel(
        id: map['id'] as int?,
        title: map['title'] as String,
        description: map['description'] as String,
        isCompleted: (map['is_completed'] as int) == 1,
        date: DateTime.parse(map['date'] as String),
        priority: TaskPriority.fromValue(map['priority'] as int),
      );
    } catch (e) {
      throw FormatException('Failed to parse TaskModel: $e');
    }
  }

  // Méthodes d'égalité et hashcode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TaskModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isCompleted == isCompleted &&
        other.date == date &&
        other.priority == priority;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isCompleted.hashCode ^
        date.hashCode ^
        priority.hashCode;
  }

  // Méthode toString pour le débogage
  @override
  String toString() {
    return 'TaskModel('
        'id: $id, '
        'title: $title, '
        'description: $description, '
        'isCompleted: $isCompleted, '
        'date: ${date.toIso8601String()}, '
        'priority: ${priority.name})';
  }


  
}
extension TaskModelMapper on TaskModel {
  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      date: date,
      priority: priority,
    );
  }
}


