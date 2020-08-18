import 'dart:async';

import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {

  //---Text Controllers -----------------------------------------------------
  TextEditingController titleInputController;
  TextEditingController tasksInputController = new TextEditingController();

  List<TextEditingController> _controller = new List();
  List<TextEditingController> _childController = new List();

  List<TextEditingController> _childTextController = new List();

  var testList = new List();
  //-------------------------------------------------------------------------

  ScrollController scrollController = new ScrollController();

  List<String> lItems = [];

  int i;

  List<Widget> list = new List();
  List<String> savedText = new List();

  String saved = '';

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  List keyList = [GlobalKey<AnimatedListState>()];

  bool clicked = false;

  List<int> _items = [];

  int counter = 0;

  int pos;

  int index1 = -1;
  int keyIndex = -1;

  double cardHeight = 250;

  Widget childCard(BuildContext context, int index, animation) {
    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic),
        child: Container(
            padding: EdgeInsets.only(left: 24, right: 8, top: 8, bottom: 4),
            child: Container(
                child: Material(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  child: Column(
                    children: <Widget>[
                      new TextField(
                        controller: testList[index1][index],
                        autofocus: false,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontFamily: "SourceSansPro",
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[800],
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          hintText: 'child',
                          hintStyle: TextStyle(
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[500],
                            fontSize: 15,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey[100],
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey[100],
                              )),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 16, right: 16, top: 12, bottom: 16),
                        ),
                      ),
                    ],
                  ),
            ))));
  }

  Widget sectionCard(BuildContext context, int index, animation) {

    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
      ),
      child: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
          child: Container(
              child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 1,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: new TextField(
                          autofocus: false,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          controller: _controller[index],
                          style: TextStyle(
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[800],
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Section ' +
                                '${_controller.indexOf(_controller[index]) + 1}',
                            hintStyle: TextStyle(
                              fontFamily: "SourceSansPro",
                              fontWeight: FontWeight.w800,
                              color: Colors.grey[500],
                              fontSize: 20,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[100],
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.grey[100],
                                )),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 16, right: 16, top: 12, bottom: 16),
                          ),
                        ),
                      ),
                      AnimatedList(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          key: keyList[keyIndex],
                          initialItemCount: _childController.length,
                          itemBuilder:
                              (BuildContext context, int index, animation) {

                            return childCard(context, index, animation);
                          }),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 24, top: 4, bottom: 4),
                            child: ButtonTheme(
                              minWidth: 10,
                              height: 30,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: FlatButton.icon(
                                icon: Icon(Icons.add,
                                    color: Colors.white, size: 12),
                                disabledColor: Colors.blueAccent,
                                color: Colors.blueAccent,
                                splashColor: Colors.deepOrange[100],
                                label: Text("ADD",
                                    style: TextStyle(
                                        fontFamily: "SourceSansPro",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: Colors.white,
                                        letterSpacing: 1.25)),
                                onPressed: () {

                                  testList[index1].add(new TextEditingController());

                                  keyList[keyIndex].currentState.insertItem(0,
                                      duration: const Duration(milliseconds: 500));
                                  setState(() {});
                                },
                              ),
                            ),
                          ))
                    ],
                  )))),
    );
  }

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        scrollController.jumpTo(scrollController.position.maxScrollExtent));
    return SafeArea(
      child: new Scaffold(
        body: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.blue[200],
                height: scrHeight / 3,
              ),
              AnimatedList(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  key: listKey,
                  initialItemCount: _controller.length,
                  itemBuilder: (BuildContext context, int index, animation) {

                    pos = index;

                    return sectionCard(context, index, animation);
                  }),
              Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    children: <Widget>[
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FlatButton.icon(
                          color: Colors.pink[500],
                          splashColor: Colors.deepPurple[100],
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text("NEW SECTION",
                              style: TextStyle(
                                  fontFamily: "SourceSansPro",
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 1.25)),
                          onPressed: () {
                            keyIndex++;

                            keyList.add(new GlobalKey<AnimatedListState>());

                            testList.add(_childTextController);

                            index1++;

                            if (_controller.length == 0) {
                              _controller.add(new TextEditingController());
                              listKey.currentState.insertItem(0,
                                  duration: const Duration(milliseconds: 500));
                            } else if (_controller.length > 0) {
                              _controller.add(new TextEditingController());
                              listKey.currentState.insertItem(
                                  _controller.length - 1,
                                  duration: const Duration(milliseconds: 500));
                            }

                            setState(() {});

                            maxScroll();
                          },
                        ),
                      ),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FlatButton.icon(
                          color: Colors.pink[500],
                          splashColor: Colors.deepPurple[100],
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text("Add into inner list",
                              style: TextStyle(
                                  fontFamily: "SourceSansPro",
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 1.25)),
                          onPressed: () {

                            _childTextController.add(new TextEditingController());

                             testList.add(_childTextController);
                          },
                        ),
                      ),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FlatButton.icon(
                          color: Colors.pink[500],
                          splashColor: Colors.deepPurple[100],
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text("Print list",
                              style: TextStyle(
                                  fontFamily: "SourceSansPro",
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 1.25)),
                          onPressed: () {
                            print(testList);
                            print(_childTextController.length);
                            print(testList.sublist(1));
                            print(testList[0]);
                          },
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            int listLength = _controller.length;
            if (this.clicked == false) {
              for (this.i = 0; i < listLength; i++) {
                //print(_controller[i].text);
                savedText.add(_controller[i].text);
                print(i);
              }
              //this.clicked = true;
            } else if (this.clicked == true) {
              print("button disabled!");
            }

            String len = _controller.length.toString();

            print(_controller[pos].text);
          },
          child: new Icon(Icons.add),
        ),
      ),
    );
  }

  maxScroll() async {
    Timer(
      Duration(milliseconds: 50),
      () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + cardHeight,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );
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
