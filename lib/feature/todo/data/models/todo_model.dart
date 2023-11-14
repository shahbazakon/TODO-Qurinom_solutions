import 'package:done_it/feature/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  final String task;
  final int id;

  TodoModel({
    required this.task,
    required this.id,
  }) : super(id: id, task: task);

  String getTaskTitle() {
    return task.split("\n")[0];
  }

  // String getTaskBodyPreview() {
  //   if (task.length > 30) {
  //     if (task.length > 256) {
  //       return task.substring(0, 120);
  //     } else {
  //       return task.substring(20);
  //     }
  //   } else {
  //     return '';
  //   }
  // }

  String getTaskBodyPreview() {
    List<String> lst = task.split("\n");
    lst.removeAt(0);
    String body = "";
    lst.forEach((element) {
      body = element + "\n";
    });
    return body;
  }

  String getTaskFullBody() {
    return task;
  }
}
