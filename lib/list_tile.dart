import 'package:flutter/material.dart';
Widget ShowDataOnScreen(List<Map> list) {
  return Column(
    children: [
      Flexible(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Expanded(
              child: Card(
                color: Colors.pink[200],
                child: Container(
                  height: 90,
                  width: 120,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 50,
                      child: Text("${list[index]['time']}",style: TextStyle(fontSize: 14),),
                    ),
                    title: Text(
                      "${list[index]['title']}",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                    subtitle: Text("${list[index]['date']}",style: TextStyle(fontSize: 18),),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
