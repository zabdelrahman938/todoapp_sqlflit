import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqlflit/todo_cubit.dart';

//import 'package:todo_sqlflit/list_tile.dart';
import 'list_tile.dart';

class NewTask extends StatelessWidget {
  const NewTask({super.key, required this.newTasks});

  final List<Map>newTasks;

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: ShowData(newTasks: newTasks),
        );
      },
    );
  }
}