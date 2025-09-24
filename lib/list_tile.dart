import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqlflit/todo_cubit.dart';
class ShowData extends StatelessWidget {
  final List<Map>tasks;
  const ShowData({super.key, required this.tasks});


  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TodoCubit>(context);
    Widget ShowDataOnScreen(List<Map> list) {
      return Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: cubit.list.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.pink[200],
                  child: Container(
                    height: 90,
                    width: 120,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 50,
                        child: Text("${cubit.list[index]['time']}",style: TextStyle(fontSize: 14),),
                      ),
                      title: Text(
                        "${cubit.list[index]['title']}",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                      ),
                      subtitle: Text("${cubit.list[index]['date']}",style: TextStyle(fontSize: 18),),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }


    return ShowDataOnScreen(tasks);
  }
}

