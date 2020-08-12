import 'package:colltest/home_view.dart';
import 'package:flutter/material.dart';
import 'package:colltest/home_view.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {

  TextEditingController titleInputController;
  TextEditingController tasksInputController = TextEditingController();

  String saved = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CustomScrollView(
                slivers: <Widget>[
                  NewTaskAppBar(),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                              child: TextField(
                                textAlign: TextAlign.left,
                                cursorColor: Colors.blueAccent,
                                controller: tasksInputController,
                                style: TextStyle(
                                  fontFamily: "SourceSansPro",
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  contentPadding: EdgeInsets.only(
                                      left: 20, top: 20, bottom: 20),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide()),
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
                                      borderRadius: BorderRadius.circular(8)),
                                  hintText: 'Title',
                                  hintStyle: TextStyle(
                                    fontFamily: "SourceSansPro",
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                              child: TextField(
                                textAlign: TextAlign.left,
                                cursorColor: Colors.blueAccent,
                                controller: tasksInputController,
                                style: TextStyle(
                                  fontFamily: "SourceSansPro",
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  contentPadding: EdgeInsets.only(
                                      left: 20, top: 20, bottom: 20),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide()),
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
                                      borderRadius: BorderRadius.circular(8)),
                                  hintText: 'Title',
                                  hintStyle: TextStyle(
                                    fontFamily: "SourceSansPro",
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            child: ButtonTheme(
                              child: FlatButton(
                                child: Text("PRINT"),
                                onPressed: () {
                                  setState(() {
                                    saved = tasksInputController.text;
                                  });

                                  printList();
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
                  )
                ],
              ))),
    );
  }

  void printList() {

    var testList = [
      saved,
      "bruh"
    ];

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
