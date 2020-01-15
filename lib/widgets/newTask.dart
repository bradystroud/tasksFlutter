import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../Database/Database.dart';
import '../Database/TaskModel.dart';
import './textField.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text("New Task"),
        ),
        body: NewTaskDetails());
  }
}

class NewTaskDetails extends StatefulWidget {
  @override
  _NewTaskDetailsState createState() => _NewTaskDetailsState();
}

class _NewTaskDetailsState extends State<NewTaskDetails> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFieldWidget("Task title", 30, controller1),
          TextFieldWidget("Task description", 100, controller2),
          FlatButton(
            onPressed: () async {
              Task task = Task(
                heading: controller1.text,
                context: controller2.text,
                status: false,
              );
              await DBProvider.db.newTask(task);
              setState(() {});
              print("Added "+controller1.text+" and "+controller2.text);
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
