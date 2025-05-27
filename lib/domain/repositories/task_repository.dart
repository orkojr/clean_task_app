import 'package:clean_task_app/domain/entities/task.dart';
import 'package:clean_task_app/domain/entities/task_priority.dart';

abstract class TaskRepository {
  Future<int> createTask(Task task);
  Future<List<Task>> getTasks();
  Future<void> updateTask(Task task);
  Future<void> updateTaskPriority(int taskId, TaskPriority newPriority); // Nouvelle méthode
  Future<void> deleteTask(int id);
}