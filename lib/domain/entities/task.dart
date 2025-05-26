// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime date;
  final int priority;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.date,
    required this.priority,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? date,
    int? priority,
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
