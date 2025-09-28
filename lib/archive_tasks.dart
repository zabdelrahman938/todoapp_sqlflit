import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqlflit/todo_cubit.dart';

//import 'package:todo_sqlflit/list_tile.dart';
import 'listtile_archiveTasks.dart';

class ArchiveTasks extends StatelessWidget {
  const ArchiveTasks({super.key, required this.archiveTasks});

  final List<Map>archiveTasks;

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: ShowData(archiveTasks: archiveTasks),
        );
      },
    );
  }
}