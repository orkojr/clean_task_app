import 'package:clean_task_app/domain/entities/task.dart';
import 'package:clean_task_app/domain/repositories/task_repository.dart';

class UpdateTask {
    TaskRepository repository;
    UpdateTask(this.repository);
    Future<void> call(Task task) async {
        await repository.updateTask(task);
    }
}