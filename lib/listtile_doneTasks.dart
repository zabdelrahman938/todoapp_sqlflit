import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqlflit/todo_cubit.dart';
class ShowData extends StatelessWidget {
  final List<Map>doneTasks;
  const ShowData({super.key, required this.doneTasks});


  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TodoCubit>(context);
    Widget ShowDataOnScreen(List<Map> doneTasks) {
      return Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: cubit.doneTasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key:Key("${doneTasks[index]['id'].toString()}"),
                  child: Card(
                    color: Colors.purple[100],
                    child: Container(
                      height: 90,
                      width: 150,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 50,
                          child: Text("${cubit.doneTasks[index]['time']}",style: TextStyle(fontSize: 14),),
                        ),
                        title: Text(
                          "${cubit.doneTasks[index]['title']}",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                        subtitle: Text("${cubit.doneTasks[index]['date']}",style: TextStyle(fontSize: 18),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: (){
                              cubit.updateDatabase(status: "done", id:doneTasks[index]['id']);
                            }, icon:Icon(Icons.check_box),color:Colors.black,),

                            IconButton(onPressed: (){
                              cubit.updateDatabase(status: "archive", id:doneTasks[index]['id']);
                            }, icon:Icon(Icons.archive),color: Colors.black,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (direction){
                    cubit.deleteDatabase(id: doneTasks[index]['id']);
                  },
                );
              },
            ),
          ),
        ],
      );
    }


    return ShowDataOnScreen(doneTasks);
  }
}

