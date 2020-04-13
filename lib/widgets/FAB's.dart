//I want to create a bouncing FAB animation


import 'package:flutter/material.dart';
import 'dart:io';

import 'newTask.dart';

class FancyFab extends StatefulWidget {
  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  double start;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }


  @override
  
  void run() {
    _controller.forward();
    sleep(const Duration(seconds: 1));
    _controller.reverse();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewTask()),
    );
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1.25 - _controller.value;
    run();
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(
        scale: _scale,
        child: _animatedButtonUI,
      ),
    );
  }

  Widget get _animatedButtonUI => FloatingActionButton(
        child: Icon(Icons.add),
      );
}

class LazyFab extends StatefulWidget {
  @override
  _LazyFabState createState() => _LazyFabState();
}

class _LazyFabState extends State<LazyFab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewTask()),
        );
      },
    );
  }
}
