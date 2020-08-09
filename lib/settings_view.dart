import 'package:colltest/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:colltest/main.dart';
import 'dart:io';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String appDocPath;
  String imagePath;
  File newImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: CustomScrollView(slivers: [
          MyAppBar(),
        ]),
      ),
      drawer: AppDrawer("settings"),
    );
  }

}
