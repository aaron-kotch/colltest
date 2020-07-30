import 'package:colltest/home_view.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:colltest/main.dart';
import 'dart:io';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:floating_search_bar/ui/sliver_search_bar.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  File _image;
  File _croppedImage;
  File _savedImage;
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
