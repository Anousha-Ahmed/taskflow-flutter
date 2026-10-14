import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/task_service.dart';
import '../../../app/constants/app_strings.dart';

class TaskController extends GetxController {
  final _taskService = Get.find<TaskService>();
  final _uuid = const Uuid();

  final tasks = <TaskModel>[].obs;
  final filteredTasks = <TaskModel>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;
  final filter = 'All'.obs;
  final sortBy = 'createdAt'.obs;

  final totalTasksRx = 0.obs;
  final completedTasksRx = 0.obs;
  final pendingTasksRx = 0.obs;

  late UserModel user;

  void setUser(UserModel u) {
    user = u;
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      isLoading.value = true;
      final list = await _taskService.getTasks(user.id);
      tasks.assignAll(list);
      _applyFilters();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _applyFilters() {
    totalTasksRx.value = tasks.length;
    completedTasksRx.value = tasks.where((t) => t.isCompleted).length;
    pendingTasksRx.value = tasks.where((t) => !t.isCompleted).length;

    var list = tasks.toList();

    if (filter.value == 'Pending') {
      list = list.where((t) => !t.isCompleted).toList();
    } else if (filter.value == 'Completed') {
      list = list.where((t) => t.isCompleted).toList();
    }

    if (searchQuery.value.isNotEmpty) {
      list = list
          .where((t) => t.title
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    switch (sortBy.value) {
      case 'priority':
        list.sort((a, b) => b.priority.index.compareTo(a.priority.index));
        break;
      case 'dueDate':
        list.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      default:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    filteredTasks.assignAll(list);
  }

  void setFilter(String f) {
    filter.value = f;
    _applyFilters();
  }

  void setSort(String s) {
    sortBy.value = s;
    _applyFilters();
  }

  void search(String q) {
    searchQuery.value = q;
    _applyFilters();
  }

  Future<void> addTask({
    required String title,
    required String description,
    required DateTime dueDate,
    required TaskPriority priority,
  }) async {
    try {
      final task = TaskModel(
        id: _uuid.v4(),
        userId: user.id,
        title: title,
        description: description,
        dueDate: dueDate,
        priority: priority,
        createdAt: DateTime.now(),
      );
      await _taskService.addTask(task);
      tasks.insert(0, task);
      _applyFilters();
      Get.snackbar('Success', AppStrings.taskSaved);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add task: $e');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _taskService.updateTask(task);
      final idx = tasks.indexWhere((t) => t.id == task.id);
      if (idx != -1) tasks[idx] = task;
      _applyFilters();
      Get.snackbar('Success', AppStrings.taskUpdated);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _taskService.deleteTask(id);
      tasks.removeWhere((t) => t.id == id);
      _applyFilters();
      Get.snackbar('Success', AppStrings.taskDeleted);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task: $e');
    }
  }

  Future<void> toggleComplete(TaskModel task) async {
    final updated = task.copyWith(isCompleted: !task.isCompleted);
    await _taskService.updateTask(updated);
    final idx = tasks.indexWhere((t) => t.id == task.id);
    if (idx != -1) tasks[idx] = updated;
    _applyFilters();
  }
}