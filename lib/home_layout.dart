import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqlflit/todo_cubit.dart';

import 'archive_tasks.dart';
import 'done_tasks.dart';
import 'new_task.dart';

class HomeLayout extends StatelessWidget {


  var scaffoldkey = GlobalKey<ScaffoldState>();
  var titlecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TodoCubit>(context);
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldkey,
          appBar: AppBar(
            backgroundColor: Colors.blue[100],
            title: Text(cubit.title[cubit.curruntIndex]),
          ),
          body: cubit.screens[cubit.curruntIndex],
          bottomNavigationBar: BottomNavigationBar(
              iconSize: 30,
              selectedFontSize: 24,
              unselectedFontSize: 18,
              selectedItemColor: Colors.black,
              currentIndex: cubit.curruntIndex,
              onTap: (index) {
                cubit.changeNavBar(index);
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
            if (cubit.isShowBottomSheet == false) {
              titlecontroller.clear();
              timecontroller.clear();
              datecontroller.clear();
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
                cubit.changeBottomSheet(Icon(Icons.edit), false);

              });
              cubit.changeBottomSheet(Icon(Icons.add), true);

            }
            else {
              if (formkey.currentState!.validate()) {
                Navigator.pop(context);
                cubit.changeBottomSheet(Icon(Icons.edit), false);
                cubit.InserDatabase(
                    title: titlecontroller.text,
                    date: datecontroller.text,
                    time: timecontroller.text);


              }
            }
          },
              child: cubit.IconFab
          ),

        );
      },
    );
  }



}
