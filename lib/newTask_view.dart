import 'package:colltest/home_view.dart';
import 'package:flutter/material.dart';
import 'package:colltest/home_view.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController titleInputController;
  TextEditingController tasksInputController = new TextEditingController();
  String saved = '';

  List<TextEditingController> _controller = new List();

  List<String> lItems = [];

  List<Widget> list = new List();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: 100,
              child: new Material(
                color: Colors.transparent,
                child: Container(
                    margin: EdgeInsets.all(16),
                    child: TextField(
                      cursorColor: Colors.blueAccent,
                      controller: tasksInputController,
                      style: TextStyle(
                        fontFamily: "SourceSansPro",
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 20, bottom: 20),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Task',
                        hintStyle: TextStyle(
                          fontFamily: "SourceSansPro",
                          fontWeight: FontWeight.w300,
                        ),
                        focusColor: Colors.yellow[400],
                      ),
                      onSubmitted: (text) {
                        lItems.add(text);
                        tasksInputController.clear();
                        setState(() {});
                      },
                    )),
              ),
            ),
            Container(
              child: FlatButton(
                child: Text("PRINT"),
                onPressed: () {
                  _controller.add(new TextEditingController());
                  int i = _controller.length - 1;
                  list.add(new TextField(
                    controller: _controller[i],
                    decoration: InputDecoration(
                        hintText: 'Hint ${_controller.length+1}'),));
                  print(_controller);
                  setState(() {});
                },
              ),
            ),
            Container(
              child: new Expanded(
                child: new ListView.builder(
                    itemCount: _controller.length,
                    itemBuilder: (BuildContext context, int index) {
                      Widget widget = list.elementAt(index);
                      return widget;
                    }),
              ),
            ),
            Container(
                child: new Expanded(
                    child: new ListView.builder(
                        itemCount: lItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new Text(lItems[index]);
                        }))),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            int i = _controller.length - 1;
            print(_controller[1].text);
          },
          child: new Icon(Icons.add),
        ),
      ),
    );
  }

  void printList() {
    var testList = [saved, "bruh"];

    testList.add("nice");

    print(testList);
  }
}

class NewTaskAppBar extends StatefulWidget {
  @override
  _NewTaskAppBarState createState() => _NewTaskAppBarState();
}

class _NewTaskAppBarState extends State<NewTaskAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        floating: true,
        pinned: false,
        snap: true,
        titleSpacing: 12,
        elevation: 4,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "New Task",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SourceSansPro',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ));
  }
}
