import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqlflit/todo_cubit.dart';

//import 'package:todo_sqlflit/list_tile.dart';
import 'listtile_doneTasks.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({super.key, required this.doneTasks});

  final List<Map>doneTasks;

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: ShowData(doneTasks: doneTasks),
        );
      },
    );
  }
}