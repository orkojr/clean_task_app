
import 'package:clean_task_app/domain/repositories/task_repository.dart';
class DeleteTask {

  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<void> call(int id) async {
    await repository.deleteTask(id);
  }
}
