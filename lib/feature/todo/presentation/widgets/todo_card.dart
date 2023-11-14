import 'package:done_it/feature/todo/data/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final TodoModel todoModel;
  final Function() onDelete;

  const TodoCard({Key? key, required this.todoModel, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              todoModel.getTaskTitle(),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              todoModel.getTaskBodyPreview(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
            ),
          ),
          Spacer(),
          Align(
              alignment: Alignment.bottomRight,
              child: IconButton(onPressed: onDelete, icon: Icon(Icons.delete)))
        ],
      ),
    );
  }
}
