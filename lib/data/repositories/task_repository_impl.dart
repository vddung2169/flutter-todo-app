import 'package:todo_app/data/data.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/data/repositories/task_repositories.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource _dataSource;
  TaskRepositoryImpl(this._dataSource);
  @override
  Future<void> createTask(Task task) async {
    try {
      await _dataSource.addTask(task);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    try {
      await _dataSource.deleteTask(task);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<List<Task>> getAllTasks() async {
    try {
      return await _dataSource.getTasks();
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    try {
      await _dataSource.updateTask(task);
    } catch (e) {
      throw '$e';
    }
  }
}
