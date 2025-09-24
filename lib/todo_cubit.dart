import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqlflit/home_layout.dart';

//import 'list_tile.dart';
import 'archive_tasks.dart';
import 'done_tasks.dart';
import 'new_task.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(InitToDoStates());

  bool isShowBottomSheet = false;
  late Database database;
   List<Map>list = [];
  int curruntIndex=0;

  Icon IconFab = Icon(Icons.edit);
  List<Widget>  get screens => [NewTask(tasks:list), DoneTasks(), ArchiveTasks()];
  List<String>title = ["New Task", "Done Task", "Archive task"];

  void changeNavBar(int index){
    curruntIndex=index;
    emit(ChangeNavBarStates());
  }
  void changeBottomSheet(Icon icon,bool isshowSheet){
    IconFab=icon;
    isShowBottomSheet=isshowSheet;
    emit(ChangeBottomSheetStates());

  }

  void CreateDatabase()  {
     openDatabase(
      "todo.db",
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)")
            .then((value) {
              emit(CreateDBStates());
          print('created table');
        }).catchError((error) {
          print("this error is : $error");
        });
      },
      onOpen: (db) {
        print("opened database");
        getFromDatabase(db: db).then((value) {
            list = value;
          print(value.toString());
          emit(GetDBStates());
        });
      },
    ).then((value){
      database=value;
     });
  }

  void InserDatabase(
      {required String title, required String date, required String time,}) async {
    await database.transaction((txn) async {
      return txn.rawInsert(
          "INSERT INTO tasks(title,date,time,status)VALUES('$title','$date','$time','NEW TASK')")
          .then((value) {
        print("inserted success and id is $value");
        getFromDatabase(db: database).then((value) {
          list = value;
          print(value.toString());
          emit(GetDBStates());
        });

        /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("inserted success and id is $value"),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            )
        );*/
      }).catchError((error) {
        print("this error is : $error");
      });
    },);
  }

  Future<List<Map>> getFromDatabase({required db}) async {
    return list = await db.rawQuery("SELECT * FROM tasks");
  }


}
