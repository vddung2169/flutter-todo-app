import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/ultils/ultils.dart';

class TaskDataSource {
  static final TaskDataSource _instance = TaskDataSource._();

  factory TaskDataSource() => _instance;

  TaskDataSource._() {
    _initDB();
  }

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DBKeys.dbname);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DBKeys.dbTable}(
        ${DBKeys.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DBKeys.titleColumn} TEXT,
        ${DBKeys.noteColumn} TEXT,
        ${DBKeys.timeColumn} TEXT,
        ${DBKeys.dateColumn} TEXT,
        ${DBKeys.isCompletedColumn} INTEGER
      )
    ''');
  }

  Future<int> addTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(DBKeys.dbTable, task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(DBKeys.dbTable, task.toJson(),
          where: 'id = ?', whereArgs: [task.id]);
    });
  }

  Future<int> deleteTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn
          .delete(DBKeys.dbTable, where: 'id = ?', whereArgs: [task.id]);
    });
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> data =
        await db.query(DBKeys.dbTable, orderBy: 'id DESC');
    return List.generate(data.length, (i) {
      return Task.fromJson(data[i]);
    });
  }
}
