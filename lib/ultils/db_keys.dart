import 'package:flutter/material.dart';

@immutable
class DBKeys {
  const DBKeys._();

  static const String dbTable = 'tasks';
  static const String dbname = 'tasks.db';
  static const String idColumn = 'id';
  static const String titleColumn = 'title';
  static const String noteColumn = 'v';
  static const String timeColumn = 'time';
  static const String dateColumn = 'date';
  static const String isCompletedColumn = 'isCompleted';
}
