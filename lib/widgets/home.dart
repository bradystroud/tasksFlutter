import 'package:flutter/material.dart';

import 'list.dart';
import 'coolHeader.dart';
import '../Database/Database.dart';
import '../Database/TaskModel.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> testTasks = [
    Task(
      heading: "Do dishes",
      context: "or mum be sad",
      status: false,
    ),
    Task(
      heading: "Wash car",
      context: "",
      status: true,
    ),
    Task(
      heading: "Stay snazzy",
      context: "write code. 1 hr a day",
      status: false,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[CoolHeader()];
        },
        body: TasksView(),
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