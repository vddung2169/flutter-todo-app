import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/data.dart';

final taskDatasourceProvider = Provider<TaskDataSource>((ref) {
  return TaskDataSource();
});
