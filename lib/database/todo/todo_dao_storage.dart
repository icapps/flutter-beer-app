import 'package:drift/drift.dart';
import 'package:beer_app/database/beer_app_database.dart';
import 'package:beer_app/model/database/todo/db_todo_table.dart';
import 'package:beer_app/model/webservice/todo/todo.dart';
import 'package:injectable/injectable.dart';

part 'todo_dao_storage.g.dart';

@lazySingleton
abstract class TodoDaoStorage {
  @factoryMethod
  factory TodoDaoStorage(BeerAppDatabase db) = _TodoDaoStorage;

  Stream<List<DbTodo>> getAllTodosStream();

  Future<List<DbTodo>> getAllTodos();

  Future<void> createTodo(String todo);

  Future<void> createTodoWithValue(Todo todo);

  Future<void> updateTodo({required int id, required bool completed});
}

@DriftAccessor(tables: [
  DbTodoTable,
])
class _TodoDaoStorage extends DatabaseAccessor<BeerAppDatabase> with _$_TodoDaoStorageMixin implements TodoDaoStorage {
  _TodoDaoStorage(super.db);

  @override
  Future<List<DbTodo>> getAllTodos() => select(db.dbTodoTable).get();

  @override
  Stream<List<DbTodo>> getAllTodosStream() => select(db.dbTodoTable).watch();

  @override
  Future<void> createTodo(String todo) => into(db.dbTodoTable).insert(DbTodoTableCompanion.insert(title: todo, completed: false));

  @override
  Future<void> createTodoWithValue(Todo todo) async => into(db.dbTodoTable).insert(DbTodoTableCompanion.insert(title: todo.title, completed: todo.completed));

  @override
  Future<void> updateTodo({required int id, required bool completed}) =>
      (update(db.dbTodoTable)..where((todo) => todo.id.equals(id))).write(DbTodoTableCompanion(completed: Value(completed)));
}
