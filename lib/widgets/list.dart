import 'package:flutter/material.dart';
import 'popup.dart';
import 'package:tasks/widgets/newTask.dart';

import '../Database/Database.dart';
import '../Database/TaskModel.dart';
import './modify.dart';
import "FAB's.dart";
import '../globals.dart' as globals;

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
          if (snapshot.data.toString() == "[]") {
            globals.fab = FancyFab();
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      "You don't have any tasks. Tap the +  below to add one."),
                ),
                RaisedButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewTask()),
                    );
                  },
                ),
              ],
            ));
          } else {
            globals.fab = LazyFab();
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                thickness: 0.15,
                indent: 10,
                endIndent: 10,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Task item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    child: Text("Delete"),
                  ),
                  //make delete like visible
                  onDismissed: (direction) {
                    DBProvider.db.deleteTasks(item.id);
                    // if(snapshot.hasData == false) {
                    //   print("YES PICKLE MEN");
                    //   showDialog(context: context);  This stuff is for a delete confirm popup but doesnt work and dont need it anyway
                    // }

                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.heading,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight
                                    .bold), //bold doesnt work on ipad on current versions
                          ),
                          Text(item.context)
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Modify(item),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.info,
                        ),
                      ),
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
                      onTap: () {
                        DBProvider.db.changeStatus(item);
                        print("status for " +
                            item.heading +
                            " is changed: " +
                            item.status.toString());
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            );
          }
        } else {
          return Center(
              child: Row(
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ));
        }
      },
    );
  }
}

void whatsFab(isBouncy) {
  var fab;
  if (isBouncy) {
    fab = FancyFab();
  } else {
    fab = LazyFab();
  }
  return fab;
}
