import 'package:flutter/material.dart';

import '../Database/Database.dart';
import '../Database/TaskModel.dart';

class TasksView extends StatefulWidget {
  @override
  _TasksViewState createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: DBProvider.db.getAllTasks(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Task item = snapshot.data[index];
              return Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  DBProvider.db.deleteTasks(item.id);
                },
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.heading,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(item.context)
                    ],
                  ),
                  trailing: IconButton(onPressed: () {}, icon: Icon(Icons.info),),
                  leading: Checkbox(
                    onChanged: (bool value) {
                      DBProvider.db.changeStatus(item);
                      print("status for " +
                          item.heading +
                          " is changed: " +
                          item.status.toString());
                      setState(() {});
                    },
                    value: item.status,
                  ),
                  // onTap: () {
                  //   DBProvider.db.changeStatus(item);
                  //   print("status for " +
                  //       item.heading +
                  //       " is changed: " +
                  //       item.status.toString());
                  //   setState(() {});
                  // },
                ),
              );
            },
          );
        } else {
          return Center(child: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              Text("No tasks. Tap the + button to make one.")
            ],
          ));
        }
      },
    );
  }
}
