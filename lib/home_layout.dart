import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'archive_tasks.dart';
import 'done_tasks.dart';
import 'new_task.dart';

class HomeLayout extends StatefulWidget {
    HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int curruntIndex = 1;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  late Database database;
  List<Widget>  get screens => [NewTask(), DoneTasks(tasks: list), ArchiveTasks()];
  List<String>title = ["New Task", "Done Task", "Archive task"];
  bool isShowBottomSheet = false;
  var titlecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  Icon IconFab = Icon(Icons.edit);
   static List<Map>list=[];



  @override
  void initState() {
    super.initState();
    CreateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Text(title[curruntIndex]),
      ),
      body: screens[curruntIndex],
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          selectedFontSize:24 ,
          unselectedFontSize: 18,
          selectedItemColor: Colors.black,
          currentIndex: curruntIndex,
          onTap: (index) {
            setState(() {
              curruntIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue[100],
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_box_outlined), label: "Done"),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: "Archive"),
          ]
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        if (isShowBottomSheet == false) {
          scaffoldkey.currentState!.showBottomSheet((context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      onTap: () {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this is required";
                        }
                      },
                      controller: titlecontroller,
                      decoration: InputDecoration(
                          label: Text("Title"),
                          prefixIcon: Icon(Icons.title),
                          border: OutlineInputBorder()


                      ),

                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      onTap: () {
                        showTimePicker(context: context,
                            initialTime: TimeOfDay.now()
                        ).then((value) {
                          timecontroller.text = value!.format(context);
                        }).catchError((error) {
                          print("this error is $error");
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this is required";
                        }
                      },
                      controller: timecontroller,
                      decoration: InputDecoration(
                          label: Text("time"),
                          prefixIcon: Icon(Icons.watch_later_outlined),
                          border: OutlineInputBorder()

                      ),

                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      onTap: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse("2026-06-06")
                        ).then((value) {
                          datecontroller.text =
                          "${value!.year}-${value.month}-${value.day}";
                        }).catchError((error) {
                          print("this error is : $error");
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this is required";
                        }
                      },
                      controller: datecontroller,
                      decoration: InputDecoration(
                          label: Text("Date"),
                          prefixIcon: Icon(Icons.date_range),
                          border: OutlineInputBorder()

                      ),

                    ),

                  ],
                ),
              ),
            );
          }).
          closed.then((value) {
            isShowBottomSheet = false;
            setState(() {
              IconFab = Icon(Icons.edit);
            });
          });
          isShowBottomSheet = true;
          setState(() {
            IconFab = Icon(Icons.add);
          });
        }
        else {
          if (formkey.currentState!.validate()) {
            Navigator.pop(context);
            isShowBottomSheet = false;
            setState(() {
              IconFab = Icon(Icons.edit);
            });
            InserDatabase(
                title: titlecontroller.text,
                date: datecontroller.text,
                time: timecontroller.text);
          }

        }
      },
          child: IconFab
      ),

    );
  }


  void CreateDatabase() async {
    database = await openDatabase(
      "todo.db",
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)")
            .then((value) {
          print('created table');
        }).catchError((error) {
          print("this error is : $error");
        });
      },
      onOpen: (db) {
        print("opened database");
        getFromDatabase(db:db).then((value){
          setState(() {
            list = value;
          });
          print(value.toString());
        });
      },
    );
  }

  void InserDatabase(
      {required String title, required String date, required String time,}) async {
    await database.transaction((txn) async {
      return txn.rawInsert(
          "INSERT INTO tasks(title,date,time,status)VALUES('$title','$date','$time','NEW TASK')")
          .then((value) {
        print("inserted success and id is $value");
        getFromDatabase(db: database).then((value) {
          setState(() {
            list = value;
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("inserted success and id is $value"),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            )
        );
      }).catchError((error) {
        print("this error is : $error");
      });
    },);
  }

  Future<List<Map>> getFromDatabase({required db}) async{


    return list = await db.rawQuery("SELECT * FROM tasks");

  }


}
