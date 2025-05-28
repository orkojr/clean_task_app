// lib/presentation/bindings/app_binding.dart

import 'package:clean_task_app/data/datasources/task_local_datasource.dart';
import 'package:get/get.dart';
import 'package:clean_task_app/presentation/controllers/task_controller.dart';
import 'package:clean_task_app/domain/usecases/create_task.dart';
import 'package:clean_task_app/domain/usecases/delete_task.dart';
import 'package:clean_task_app/domain/usecases/get_tasks.dart';
import 'package:clean_task_app/domain/usecases/update_task.dart';
import 'package:clean_task_app/domain/usecases/update_task_priority.dart';
import 'package:clean_task_app/data/repositories/task_repository_impl.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    final localDataSource = TaskLocalDataSource.instance;
    final repository = TaskRepositoryImpl(localDataSource:localDataSource);

    Get.put(TaskController(
      createTaskUseCase: CreateTask(repository),
      deleteTaskUseCase: DeleteTask(repository),
      getTasksUseCase: GetTasks(repository),
      updateTaskUseCase: UpdateTask(repository),
      updatePriorityUseCase: UpdateTaskPriority(repository),
    ));
  }
}
