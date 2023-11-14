import 'package:done_it/core/presentation/some_went_wrong_page.dart';
import 'package:done_it/feature/todo/data/models/todo_model.dart';
import 'package:done_it/feature/todo/presentation/blocs/todo_form/todo_form_bloc.dart';
import 'package:done_it/feature/todo/presentation/pages/todo_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoPage extends StatefulWidget {
  static const routeName = '/AddTodoPage';

  final TodoModel? todoModel;
  const AddTodoPage({Key? key, this.todoModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddTodoPageState();
  }
}

class AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();
  String? _task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState?.validate() == true && _task != null) {
                _formKey.currentState?.save();
                BlocProvider.of<TodoFormBloc>(context).add(
                  TodoFormAddEvent(
                    task: _task!,
                  ),
                );
              }
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoHomePage(
                        isUpdated: true, updatedTodoModel: widget.todoModel),
                  ),
                  (route) => false);
            },
          )
        ],
      ),
      body: BlocBuilder<TodoFormBloc, TodoFormState>(
        builder: (BuildContext context, TodoFormState todoFormState) {
          if (todoFormState is TodoFormInitialState) {
            return _buildBody(context);
          } else if (todoFormState is TodoFormLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (todoFormState is TodoFormAddSuccessState) {
            return _buildBody(context);
          } else if (todoFormState is TodoFormAddFailState) {
            return _buildBody(context);
          }
          return SomeThingWentWrongPage();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TextFormField(
                initialValue: widget.todoModel?.getTaskFullBody(),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Title \nDescription"),
                scrollPadding: EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                maxLines: 99999,
                autofocus: true,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) {
                  _task = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
