import 'package:clean_task_app/domain/entities/task.dart';

abstract class TaskRepository {
  Future<int> createTask(Task task);
  Future<List<Task>> getTasks();
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int id);
}