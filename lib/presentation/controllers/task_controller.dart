
import 'package:get/get.dart';
import 'package:clean_task_app/domain/entities/task.dart';
import 'package:clean_task_app/domain/entities/task_priority.dart';
import 'package:clean_task_app/domain/usecases/create_task.dart';
import 'package:clean_task_app/domain/usecases/delete_task.dart';
import 'package:clean_task_app/domain/usecases/get_tasks.dart';
import 'package:clean_task_app/domain/usecases/update_task.dart';
import 'package:clean_task_app/domain/usecases/update_task_priority.dart';
import 'package:clean_task_app/core/errors/exceptions.dart';

class TaskController extends GetxController {
  final CreateTask createTaskUseCase;
  final DeleteTask deleteTaskUseCase;
  final GetTasks getTasksUseCase;
  final UpdateTask updateTaskUseCase;
  final UpdateTaskPriority updatePriorityUseCase;

  TaskController({
    required this.createTaskUseCase,
    required this.deleteTaskUseCase,
    required this.getTasksUseCase,
    required this.updateTaskUseCase,
    required this.updatePriorityUseCase,
  });

  var tasks = <Task>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      final result = await getTasksUseCase();
      tasks.assignAll(result);
    } catch (e) {
      errorMessage.value = _handleException(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await createTaskUseCase(task);
      await fetchTasks();
    } catch (e) {
      errorMessage.value = _handleException(e);
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await deleteTaskUseCase(id);
      await fetchTasks();
    } catch (e) {
      errorMessage.value = _handleException(e);
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await updateTaskUseCase(task);
      await fetchTasks();
    } catch (e) {
      errorMessage.value = _handleException(e);
    }
  }

  Future<void> changePriority(int id, TaskPriority newPriority) async {
    try {
      await updatePriorityUseCase(id, newPriority);
      await fetchTasks();
    } catch (e) {
      errorMessage.value = _handleException(e);
    }
  }

  String _handleException(Object e) {
    if (e is DatabaseException || e is CacheException || e is UnexpectedException) {
      return e.toString();
    }
    return 'Erreur inconnue : $e';
  }


  Future<void> toggleCompletion(Task task) async {
  try {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await updateTaskUseCase(updatedTask);
    await fetchTasks();
  } catch (e) {
    errorMessage.value = _handleException(e);
  }
}
}
