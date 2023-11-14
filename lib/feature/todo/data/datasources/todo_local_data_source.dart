import 'package:collection/collection.dart';
import 'package:done_it/core/error/exceptions.dart';
import 'package:done_it/feature/todo/data/models/todo_model.dart';
import 'package:done_it/feature/todo/domain/entities/todo.dart';

abstract class TodoLocalDataSource {
  ///Throws [DataBaseException] if no data found
  Future<TodoModel> getTodo(int id);

  Future<List<TodoModel>> getAllTodo();

  Future<Todo> addTodo(String task);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  TodoLocalDataSourceImpl();

  // This is a dummy in memory data source to mock a local database
  List<TodoModel> todoModelList = [
    TodoModel(
        task:
            'Qurinom Solution \nYou can Add Notes Delete Notes and Also Updated Notes, ',
        id: 0),
  ];

  @override
  Future<TodoModel> getTodo(int id) {
    final TodoModel? todoModel =
        todoModelList.firstWhereOrNull((element) => element.id == id);
    if (todoModel != null) {
      return Future.delayed(const Duration(seconds: 1), () => todoModel);
    } else {
      throw DataBaseException();
    }
  }

  @override
  Future<List<TodoModel>> getAllTodo() {
    return Future.delayed(const Duration(seconds: 1), () => todoModelList);
  }

  @override
  Future<Todo> addTodo(String task) {
    return Future.delayed(const Duration(seconds: 1), () {
      final todo = TodoModel(task: task, id: todoModelList.length);
      todoModelList.add(todo);
      return todo;
    });
  }
}
