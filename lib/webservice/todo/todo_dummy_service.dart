import 'package:beer_app/di/environments.dart';
import 'package:beer_app/model/webservice/todo/todo.dart';
import 'package:beer_app/styles/theme_durations.dart';
import 'package:beer_app/util/api/dummy_api_util.dart';
import 'package:beer_app/webservice/todo/todo_service.dart';
import 'package:injectable/injectable.dart';

@dummy
@Singleton(as: TodoService)
class TodoDummyService extends TodoService {
  final todos = <Todo>[];

  @override
  Future<List<Todo>> getTodos() async {
    await Future<void>.delayed(ThemeDurations.demoNetworkCallDuration());
    if (todos.isEmpty) {
      final result = await DummyApiUtil.getResponse<List<dynamic>>('todos');
      final newTodos = result.map((dynamic item) => Todo.fromJson(item as Map<String, dynamic>)).toList();
      todos.addAll(newTodos);
    }
    return todos;
  }
}
