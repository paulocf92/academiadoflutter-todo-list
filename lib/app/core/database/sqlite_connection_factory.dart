import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class SqliteConnectionFactory {
  static const _VERSION = 1;
  static const _DATABASE_NAME = 'TODO_LIST_PROVIDER';

  static SqliteConnectionFactory? _instance;

  Database? _db;
  final _lock = Lock();

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    if (_instance == null) {
      _instance = SqliteConnectionFactory._();
    }
    return _instance!;
  }

  Future<Database> openConnection() async {
    var databasePath = await getDatabasesPath();
    var databasePathFinal = join(databasePath, _DATABASE_NAME);
    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          _db = await openDatabase(
            databasePathFinal,
            version: _VERSION,
          );
        }
      });
    }
    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }
}
