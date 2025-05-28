// lib/data/datasources/local/task_local_data_source.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskLocalDataSource {
  static const _databaseName = 'tasks_database.db';
  static const _databaseVersion = 1;

  static const table = 'tasks';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnIsCompleted = 'is_completed';
  static const columnDate = 'date';
  static const columnPriority = 'priority';

  // Singleton pattern
  TaskLocalDataSource._privateConstructor();
  static final TaskLocalDataSource instance =
      TaskLocalDataSource._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName); // Correction ici

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnDescription TEXT,
        $columnIsCompleted INTEGER NOT NULL DEFAULT 0,
        $columnDate TEXT NOT NULL,
        $columnPriority INTEGER NOT NULL
      )
    ''');

    // Index pour les requêtes fréquentes
    await db.execute('''
      CREATE INDEX idx_priority ON $table ($columnPriority)
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Exemple de migration pour une future version
      await db.execute('ALTER TABLE $table ADD COLUMN category TEXT');
    }
  }

  // CRUD Operations
  Future<int> insertTask(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllTasks() async {
    final db = await database;
    return await db.query(table);
  }

  Future<int> updateTask(Map<String, dynamic> row) async {
    final db = await database;
    final id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateTaskPriority(int id, int newPriority) async {
    final db = await database;
    return await db.update(
      table,
      {columnPriority: newPriority},
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> queryTasksByPriority(int priority) async {
    final db = await database;
    return await db.query(
      table,
      where: '$columnPriority = ?',
      whereArgs: [priority],
    );
  }
}
