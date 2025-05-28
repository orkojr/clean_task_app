import 'package:clean_task_app/data/datasources/task_local_datasource.dart';
import 'package:clean_task_app/domain/entities/task.dart';
import 'package:clean_task_app/domain/entities/task_priority.dart';
import 'package:clean_task_app/domain/repositories/task_repository.dart';
import 'package:clean_task_app/data/models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<int> createTask(Task task) async {
    final taskModel = TaskModel(
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      date: task.date,
      priority: task.priority,
    );
    return await localDataSource.insertTask(taskModel.toMap());
  }

  @override
  Future<List<Task>> getTasks() async {
    final result = await localDataSource.queryAllTasks();
    return result.map((map) => TaskModel.fromMap(map).toEntity()).toList();
  }

  @override
  Future<void> updateTask(Task task) async {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      date: task.date,
      priority: task.priority,
    );
    await localDataSource.updateTask(model.toMap());
  }

  @override
  Future<void> deleteTask(int id) async {
    await localDataSource.deleteTask(id);
  }

  @override
  Future<void> updateTaskPriority(int taskId, TaskPriority newPriority) async {
    await localDataSource.updateTaskPriority(taskId, newPriority.value);
  }

  @override
  Future<List<Task>> getTasksByPriority(TaskPriority priority) async {
    final result = await localDataSource.queryTasksByPriority(priority.value);
    return result.map((map) => TaskModel.fromMap(map).toEntity()).toList();
  }
}
