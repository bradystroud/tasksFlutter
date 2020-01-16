import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _currentSwitchValue = true;
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlatformSwitch(
              value: _currentSwitchValue,
              onChanged: (value) {
                print("changed: " + _currentSwitchValue.toString());
                setState(() {
                  _currentSwitchValue = value;
                });
              },
            ),
            PlatformSlider(
              value: _currentSliderValue,
              onChanged: (value) {
                print("changed: " + _currentSliderValue.toString());
                setState(
                  () {
                    _currentSliderValue = value;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
