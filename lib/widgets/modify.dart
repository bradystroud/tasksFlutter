import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../Database/Database.dart';
import '../Database/TaskModel.dart';
import './textField.dart';

class Modify extends StatefulWidget {
  Task task;

  Modify(this.task);
  @override
  _ModifyState createState() => _ModifyState(task);
}

class _ModifyState extends State<Modify> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  Task task;

  _ModifyState(this.task);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("Modify Task"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFieldWidget(task.heading, 30, controller1),
            TextFieldWidget(task.context, 100, controller2),
            FlatButton(
              onPressed: () async {
                Task modifiedTask = Task(
                  id: task.id,
                  heading: checkNull(task.heading, controller1.text),
                  context: checkNull(task.context, controller2.text),
                  status: task.status,
                );
                await DBProvider.db.updateTask(modifiedTask);
                setState(() {});
                print(
                    "updated " + controller1.text + " and " + controller2.text);
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

String checkNull(task, val) {
  String newval;
  if (val == "") {
    newval = task;
  } else {
    return val;
  }
  return newval;
}
