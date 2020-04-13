import 'package:flutter/material.dart';

import 'list.dart';
import 'coolHeader.dart';
import '../globals.dart' as globals;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[CoolHeader()];
        },
        body: TasksView(),
      ),
      floatingActionButton: globals.fab,
    );
  }
}
