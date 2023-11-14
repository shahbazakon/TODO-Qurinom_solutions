import 'package:done_it/feature/setting/presentation/pages/setting_page.dart';
import 'package:done_it/feature/todo/data/models/todo_model.dart';
import 'package:done_it/feature/todo/presentation/blocs/todo/todo_bloc.dart';
import 'package:done_it/feature/todo/presentation/blocs/todo_form/todo_form_bloc.dart';
import 'package:done_it/feature/todo/presentation/pages/add_todo_page.dart';
import 'package:done_it/feature/todo/presentation/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoHomePage extends StatefulWidget {
  static const routeName = '/TodoHomePage';
  bool? isUpdated;
  final TodoModel? updatedTodoModel;

  TodoHomePage({Key? key, this.isUpdated, this.updatedTodoModel})
      : super(key: key);
  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoFormBloc, TodoFormState>(
      listener: (BuildContext context, TodoFormState todoFormState) {
        if (todoFormState is TodoFormAddSuccessState) {
          context.read<TodoBloc>().add(GetTodoListEvent());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text("Qurinom Solutions TODO",
              style: TextStyle(color: Colors.black87)),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, SettingPage.routeName);
                }),
          ],
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (BuildContext context, TodoState state) {
            if (state is TodoInitialState) {
              return Center(
                child: Text("Initial State"),
              );
            } else if (state is TodoLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TodoLoadSuccessState) {
              if (widget.isUpdated ?? false) {
                state.todoList.remove(widget.updatedTodoModel);
                context.read<TodoBloc>().add(GetTodoListEvent());
                widget.isUpdated = false;
              }
              return state.todoList.length == 0
                  ? Center(
                      child: Text("Add Todo",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500)),
                    )
                  : Padding(
                      padding: EdgeInsets.all(8),
                      child: GridView.builder(
                        itemCount: state.todoList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddTodoPage(
                                          todoModel: state.todoList[index]
                                              as TodoModel)));
                            },
                            child: TodoCard(
                              key: ValueKey(index),
                              todoModel: state.todoList[index] as TodoModel,
                              onDelete: () {
                                state.todoList.removeAt(index);
                                context
                                    .read<TodoBloc>()
                                    .add(GetTodoListEvent());
                              },
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                      ),
                    );
            } else if (state is TodoLoadFailedState) {
              return Center(
                child: Text("Error Loading"),
              );
            } else {
              return Center(
                child: Text("Unexpected State"),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle),
          onPressed: () {
            Navigator.pushNamed(context, AddTodoPage.routeName);
          },
        ),
      ),
    );
  }
}
