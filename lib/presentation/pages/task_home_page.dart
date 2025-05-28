import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clean_task_app/presentation/controllers/task_controller.dart';
import 'package:clean_task_app/domain/entities/task.dart';
import 'package:clean_task_app/domain/entities/task_priority.dart';

class TaskHomePage extends StatelessWidget {
  const TaskHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gestionnaire de tâches'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Toutes'),
              Tab(text: 'Priorité'),
              Tab(text: 'Complétées'),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final allTasks = controller.tasks;
          final completedTasks = allTasks.where((t) => t.isCompleted).toList();
          final priorityTasks = allTasks.where((t) => t.priority == TaskPriority.high).toList();

          return TabBarView(
            children: [
              _buildTaskList(allTasks, controller),
              _buildTaskList(priorityTasks, controller),
              _buildTaskList(completedTasks, controller),
            ],
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.snackbar('Info', 'Ajouter une tâche — à implémenter');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildTaskList(List<Task> tasks, TaskController controller) {
    if (tasks.isEmpty) {
      return const Center(child: Text("Aucune tâche."));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: Icon(
              task.isCompleted ? Icons.check_circle : Icons.circle_outlined,
              color: task.isCompleted ? Colors.green : Colors.grey,
            ),
            onTap: () {
              controller.toggleCompletion(task);
            },
          ),
        );
      },
    );
  }
}
