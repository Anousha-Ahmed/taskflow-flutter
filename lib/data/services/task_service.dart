import '../models/task_model.dart';
import 'database_helper.dart';

class TaskService {
  final _dbHelper = DatabaseHelper.instance;

  Future<List<TaskModel>> getTasks(String userId) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'tasks',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );
    return result.map((e) => TaskModel.fromMap(e)).toList();
  }

  Future<void> addTask(TaskModel task) async {
    final db = await _dbHelper.database;
    await db.insert('tasks', task.toMap());
  }

  Future<void> updateTask(TaskModel task) async {
    final db = await _dbHelper.database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(String taskId) async {
    final db = await _dbHelper.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
  }

  Future<void> toggleComplete(TaskModel task) async {
    final updated = task.copyWith(isCompleted: !task.isCompleted);
    await updateTask(updated);
  }
}