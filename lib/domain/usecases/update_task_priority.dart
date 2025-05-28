// lib/domain/usecases/update_task_priority.dart
import 'package:clean_task_app/domain/entities/task_priority.dart';
import 'package:clean_task_app/domain/repositories/task_repository.dart';

class UpdateTaskPriority {
  final TaskRepository repository;

  UpdateTaskPriority(this.repository);

  Future<void> call(int taskId, TaskPriority newPriority) async {
    return await repository.updateTaskPriority(taskId, newPriority);
  }
}