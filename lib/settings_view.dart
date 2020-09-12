import 'package:colltest/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:colltest/main.dart';
import 'dart:io';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
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
    );
  }

}
