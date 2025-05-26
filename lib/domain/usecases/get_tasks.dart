

import 'package:clean_task_app/domain/entities/task.dart';
import 'package:clean_task_app/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() async {
    return await repository.getTasks();
  }
}