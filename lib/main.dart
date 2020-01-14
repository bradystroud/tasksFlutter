import 'package:flutter/material.dart';
import 'Database.dart';
import 'TaskModel.dart';
import 'Database.dart';
import 'dart:math' as math;

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // data for testing
  List<Task> testTasks = [
    Task(heading: "Do dishes", context: "or mum be sad", status: false),
    Task(heading: "Wash car", context: "", status: true),
    Task(
        heading: "Stay snazzy",
        context: "write code. 1 hr a day",
        status: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: FutureBuilder<List<Task>>(
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
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Task rnd = testTasks[math.Random().nextInt(testTasks.length)];
          await DBProvider.db.newTask(rnd);
          setState(() {});
        },
      ),
    );
  }
}
