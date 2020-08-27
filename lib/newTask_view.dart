import 'dart:async';

import 'package:flutter/cupertino.dart';
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

  List<GlobalKey<AnimatedListState>> cardKey = [new GlobalKey<AnimatedListState>()];

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
                      Container(
                        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 4),
                        child: TextField(
                          controller: _childTextController[index],
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[800],
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            labelText:'Description',
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
                                )
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 16, right: 16, top: 16, bottom: 16),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 16, bottom: 12, top: 16, right: 16),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              ButtonTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                disabledColor: Colors.orange[500],
                                buttonColor: Colors.orange[500],
                                child: FlatButton(
                                  disabledColor: Colors.pink[500],
                                  child: Text("ASSIGN MEMBERS",
                                    style: TextStyle(
                                      fontFamily: "SourceSansPro",
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 1.25,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 16),
                                child: Icon(Icons.check_circle, size: 20, color: Colors.greenAccent[700]),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 8),
                                child: Text("Assigned to Guano + 2",
                                  style: TextStyle(
                                    fontFamily: "SourceSansPro",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.blueAccent[100],
                                  ),
                                ),
                              )
                            ],
                          )
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
                color: Colors.blue[200],
                height: scrHeight / 3,
                margin: EdgeInsets.only(bottom: 8),
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

                            childTextControllerIndex++;
                            _childTextController.add(new TextEditingController());

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
