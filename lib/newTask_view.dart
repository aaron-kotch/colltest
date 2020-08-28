import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:colltest/edit_better_icons.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  //---Text Controllers -----------------------------------------------------
  TextEditingController titleInputController;
  TextEditingController tasksInputController = new TextEditingController();

  List<TextEditingController> _controller = new List();

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

  List<GlobalKey<AnimatedListState>> cardKey = [
    new GlobalKey<AnimatedListState>()
  ];

  bool clicked = false;

  int cardCount = 0;

  int pos;
  int pos1;

  int childTextControllerIndex = -1;

  int keyIndex = -1;

  double cardHeight = 250;

  List<Widget> cList = new List();

  List<Widget> newList = [];

  TextEditingController controller = TextEditingController();

  bool _isEditingText = false;
  TextEditingController sectionTitleController;
  List<String> initialText = new List();
  TimeOfDay timeNow = TimeOfDay.now();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    sectionTitleController.dispose();
    super.dispose();
  }

  Widget editableSectionTitle(index) {
    if (_isEditingText)
      return Container(
          alignment: Alignment.centerLeft,
          child: IntrinsicWidth(
            child: TextField(
              controller: _controller[index],
              autofocus: true,
              onSubmitted: (newValue) {
                initialText[index] = newValue;
                _isEditingText = false;
              },
              style: TextStyle(
                fontFamily: "SourceSansPro",
                fontWeight: FontWeight.w800,
                color: Colors.grey[700],
                fontSize: 20,
              ),
              decoration: InputDecoration(
                hintText: "Section title         ",
                hintStyle: TextStyle(
                  fontFamily: "SourceSansPro",
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[500],
                  fontSize: 20,
                ),
              ),
            ),
          ));
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            initialText[index],
            style: TextStyle(
              fontFamily: "SourceSansPro",
              fontWeight: FontWeight.w800,
              color: Colors.grey[700],
              fontSize: 20,
            ),
          ),
          IconButton(
              icon: Icon(Edit_better.edit, size: 16),
              color: Colors.grey[700],
              onPressed: () {
                setState(() {
                  _isEditingText = true;
                });
              })
        ],
      ),
    );
  }

  Widget sectionCard(BuildContext context, int index, animation) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
      ),
      child: Container(
          padding: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
          child: Container(
              child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 1,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 4, left: 20, top: 4),
                        child: editableSectionTitle(index),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 16, top: 16, right: 16, bottom: 4),
                        child: TextField(
                          controller: _childTextController[index],
                          maxLines: null,
                          minLines: 4,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[800],
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Description',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                              fontFamily: "SourceSansPro",
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              height: 1,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.grey[100],
                            )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.grey[500],
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                )),
                            contentPadding: EdgeInsets.only(
                                left: 16, right: 16, top: 12, bottom: 16),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
                        child: Material(
                          color: Colors.deepOrange[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          elevation: 1,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 24),
                                child: Text(
                                  "Section planner",
                                  style: TextStyle(
                                    fontFamily: "SourceSansPro",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.15,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                                width: MediaQuery.of(context).size.width,
                                child: Material(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(4),
                                        topLeft: Radius.circular(4),
                                      )),
                                  elevation: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(top: 12, bottom: 12, left: 16),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      "Start",
                                                      style: TextStyle(
                                                        fontFamily: "SourceSansPro",
                                                        fontWeight: FontWeight.w300,
                                                        color: Colors.grey[900],
                                                        letterSpacing: 0.4,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "${selectedDate.toLocal()}".split(' ')[0],
                                                      style: TextStyle(
                                                        fontFamily: "SourceSansPro",
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.grey[800],
                                                        letterSpacing: 0.25,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: IconButton(
                                                iconSize: 20,
                                                splashRadius: 20,
                                                color: Colors.yellow,
                                                icon: Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.grey[800],
                                                ),
                                                onPressed: () {

                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                width: MediaQuery.of(context).size.width,
                                child: Material(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(4),
                                        bottomLeft: Radius.circular(4),
                                      )),
                                  elevation: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(top: 12, bottom: 12, left: 16),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        "End",
                                                        style: TextStyle(
                                                          fontFamily: "SourceSansPro",
                                                          fontWeight: FontWeight.w300,
                                                          color: Colors.grey[900],
                                                          letterSpacing: 0.4,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "${selectedDate.toLocal()}".split(' ')[0],
                                                        style: TextStyle(
                                                          fontFamily: "SourceSansPro",
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.grey[800],
                                                          letterSpacing: 0.25,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: IconButton(
                                                  iconSize: 20,
                                                  splashRadius: 20,
                                                  color: Colors.yellow,
                                                  icon: Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.grey[800],
                                                  ),
                                                  onPressed: () {

                                                  },
                                                ),
                                              )
                                            ],
                                          )
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 16, bottom: 12, top: 16, right: 16),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      ButtonTheme(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4)),
                                        child: FlatButton(
                                          disabledColor: Colors.blueGrey[700],
                                          child: Text(
                                            "ASSIGN MEMBERS",
                                            style: TextStyle(
                                              fontFamily: "SourceSansPro",
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              letterSpacing: 1.25,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Icon(Icons.assignment_turned_in,
                                            size: 20, color: Colors.green[500])
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          "Assigned to Guano + 2",
                                          style: TextStyle(
                                            fontFamily: "SourceSansPro",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
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
                height: scrHeight / 10,
                padding:
                    EdgeInsets.only(top: 16, bottom: 12, left: 16, right: 16),
                child: TextField(
                  autofocus: false,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: titleInputController,
                  style: TextStyle(
                    fontFamily: "SourceSansPro",
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontFamily: "SourceSansPro",
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[400],
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.blueGrey[400],
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
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
              Container(
                alignment: Alignment.center,
                  width: scrWidth,
                  padding:
                      EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 4),
                  child: Material(
                    color: Colors.deepOrange[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 1,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 16, left: 20, bottom: 16),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Project Planner",
                            style: TextStyle(
                              fontFamily: "SourceSansPro",
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              letterSpacing: 0.15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: scrHeight / 10,
                          width: scrWidth,
                          padding: EdgeInsets.only(left: 0, right: 0, bottom: 16),
                          child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.only(left: 20),
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: <Widget>[
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Due date",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "SourceSansPro",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${selectedDate.toLocal()}"
                                                          .split(' ')[0],
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "SourceSansPro",
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 32, top: 12, bottom: 12),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Time",
                                                style: TextStyle(
                                                  fontFamily: "SourceSansPro",
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "${timeNow.format(context)}",
                                                style: TextStyle(
                                                  fontFamily: "SourceSansPro",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: EdgeInsets.only(right: 8),
                                      child: IconButton(
                                        splashRadius: 28,
                                        highlightColor: Colors.yellow,
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          selectDate(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        Container(
                          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          child: Material(
                            color: Colors.blueGrey[500],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 16, top: 12, bottom: 16),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Members",
                                    style: TextStyle(
                                      fontFamily: "SourceSansPro",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17,
                                      letterSpacing: 0.15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 16, bottom: 16),
                                  child: FlatButton.icon(
                                      icon: Icon(Icons.group_add, color: Colors.white, size: 20),
                                      label: Text("ADD MEMBERS",
                                        style: TextStyle(
                                          fontFamily: "SourceSansPro",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          letterSpacing: 1.25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  )
                              ],
                            )
                          ),
                        )
                      ],
                    ),
                  )),
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
                            childTextControllerIndex++;
                            _childTextController
                                .add(new TextEditingController());

                            testList.add(_childTextController);

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

                            initialText.add("Section Title");

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
                          label: Text("Print list",
                              style: TextStyle(
                                  fontFamily: "SourceSansPro",
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 1.25)),
                          onPressed: () {
                            print(_childTextController);

                            //print(testList.sublist(1));
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

            print(_controller[pos].text);
          },
          child: new Icon(Icons.add),
        ),
      ),
    );
  }

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
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
