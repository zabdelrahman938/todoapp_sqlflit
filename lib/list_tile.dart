import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqlflit/todo_cubit.dart';
class ShowData extends StatelessWidget {
  final List<Map>newTasks;
  const ShowData({super.key, required this.newTasks});


  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TodoCubit>(context);
    Widget ShowDataOnScreen(List<Map> newTasks) {
      return Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: cubit.newTasks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key:Key("${newTasks[index]['id'].toString()}"),
                    child: Card(
                      color: Colors.purple[100],
                      child: Container(
                        height: 90,
                        width: 150,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 50,
                            child: Text("${cubit.newTasks[index]['time']}",style: TextStyle(fontSize: 14),),
                          ),
                          title: Text(
                            "${cubit.newTasks[index]['title']}",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                          subtitle: Text("${cubit.newTasks[index]['date']}",style: TextStyle(fontSize: 18),),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: (){
                                cubit.updateDatabase(status: "done", id:newTasks[index]['id']);
                              }, icon:Icon(Icons.check_box),color:Colors.black,),

                              IconButton(onPressed: (){
                                cubit.updateDatabase(status: "archive", id:newTasks[index]['id']);
                              }, icon:Icon(Icons.archive),color: Colors.black,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    onDismissed: (direction){
                     cubit.deleteDatabase(id: newTasks[index]['id']);
                    },
                  );
                },
              ),
            ),
          ],

      );
    }


    return ShowDataOnScreen(newTasks);
  }
}

