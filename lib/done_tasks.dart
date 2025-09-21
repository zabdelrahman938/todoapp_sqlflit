import 'package:flutter/material.dart';

import 'list_tile.dart';

class DoneTasks extends StatelessWidget {
   DoneTasks({super.key,required this.tasks});
  final List<Map> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowDataOnScreen(tasks),
    );
  }
}
