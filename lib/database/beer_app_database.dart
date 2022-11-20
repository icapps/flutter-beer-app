import 'package:drift/drift.dart';
import 'package:beer_app/model/database/todo/db_todo_table.dart';

part 'beer_app_database.g.dart';

@DriftDatabase(tables: [
  DbTodoTable,
])
class BeerAppDatabase extends _$BeerAppDatabase {
  BeerAppDatabase(super.db);

  BeerAppDatabase.connect(DatabaseConnection connection) : super.connect(connection);

  @override
  int get schemaVersion => 1;

  Future<void> deleteAllData() {
    return transaction(() async {
      for (final table in allTables) {
        await delete<Table, dynamic>(table).go();
      }
    });
  }
}
