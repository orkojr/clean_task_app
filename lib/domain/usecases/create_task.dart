
import 'package:clean_task_app/domain/entities/task.dart';
import 'package:clean_task_app/domain/repositories/task_repository.dart';

class CreateTask {
  final TaskRepository repository;

  CreateTask(this.repository);

  Future<int> call(Task task) async {
    return await repository.createTask(task);
  }
}