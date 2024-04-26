import 'package:sqflite/sqlite_api.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration.dart';

class MigrationV2 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('create table test(id integer)');
  }

  @override
  void upgrade(Batch batch) {
    batch.execute('create table test(id integer)');
  }
}
