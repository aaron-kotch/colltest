import 'dart:io';
import 'dart:math';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colltest/customScrollPhysics.dart';
import 'package:colltest/font_awesome_icons.dart';
import 'package:colltest/login_view.dart';
import 'package:colltest/newTask_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:colltest/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'size_config.dart';

File _image;
File _croppedImage;
SharedPreferences prefs;
String appDocPath;
String imagePath;
String _imagePath;
File newImage;
double scrWidth;

List<String> projectTitleList = new List();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<int> pages = List.generate(4, (index) => index);
  final pageViewController = PageController(viewportFraction: 0.87);

  final cardController = ScrollController();

  ScrollPhysics scrollPhysics;

  Widget projectList() {
    return new Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: projectTitleList.length,
            itemBuilder: (context, index) {
              return Text(projectTitleList[index]);
            }
        )
    );
  }
  //---------Firestore-----------------------------------------

  final firestoreInstance = Firestore.instance;

  //----------------------------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImage();
    retrieveProjects();

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final Height = SizeConfig.blockSizeVertical;
    final Width = SizeConfig.blockSizeHorizontal;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    scrWidth = screenWidth;



    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white10,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: FutureBuilder(
        future: userName(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: Scaffold(
                backgroundColor: Colors.grey[100],
                body: SafeArea(
                  top: true,
                  child: CustomScrollView(
                    slivers: [
                      //MyAppBar(),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                                child: Container(
                                    alignment: Alignment.topRight,
                                    padding:
                                        EdgeInsets.only(top: 20, right: 20),
                                    child: IconButton(
                                      icon: Icon(
                                        FontAwesome.arrow_right,
                                        color: Colors.grey[800],
                                        size: Width * 4,
                                      ),
                                      onPressed: () {
                                        print(Width);
                                        print(projectTitleList);
                                      }
                                    ),
                                )
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 56, top: 16),
                              child: _imagePath != null
                                  ? Container(
                                      width: 80,
                                      height: 80,
                                      child: ClipOval(
                                          child: Material(
                                              color: Colors.yellow[300],
                                              child: InkWell(
                                                  splashColor: Colors.blue[300],
                                                  onTap: () {
                                                    print(MediaQuery.of(context)
                                                        .size
                                                        .width);
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            FileImage(File(
                                                                _imagePath)),
                                                        radius: 100,
                                                      ))))),
                                    )
                                  : Container(
                                      width: 80,
                                      height: 80,
                                      child: Container(
                                        child: ClipOval(
                                            child: Material(
                                                color: Colors.white,
                                                child: InkWell(
                                                    splashColor:
                                                        Colors.blue[300],
                                                    onTap: () {
                                                      print(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width);
                                                    },
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        child: CircleAvatar(
                                                          backgroundImage: newImage !=
                                                                  null
                                                              ? FileImage(File(
                                                                  prefs.getString(
                                                                      'collImage')))
                                                              : NetworkImage(
                                                                  'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_account_circle_48px-512.png'),
                                                          radius: 100,
                                                        ))))),
                                      )),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 56, top: 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "@" + "${snapshot.data.data["username"]}",
                                      style: TextStyle(
                                        fontSize: Width * 6,
                                        fontFamily: "SourceSansPro",
                                        fontWeight: FontWeight.w800,
                                        color: Colors.grey[800],
                                        letterSpacing: 0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      child: IconButton(
                                        icon: Icon(
                                          FontAwesome.edit,
                                          color: Colors.grey[800],
                                        ),
                                        iconSize: Width * 5,
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                              alignment: Alignment.center,
                              height: Height * 50,
                              padding: EdgeInsets.only(
                                  top: 24, bottom: 16, left: 32, right: 32),
                              child: Material(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: <Widget>[

                                      Container(
                                        alignment: Alignment.topLeft,
                                        height: 200,
                                        width: Width * 100,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: projectTitleList.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                  padding: EdgeInsets.only(top: 20, left: 24),
                                                  child: projectTitleList != null
                                                      ? Text("${projectTitleList[index]}",
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontFamily: "SourceSansPro",
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.grey[800],
                                                      letterSpacing: 0.25,
                                                    ),
                                                  )
                                                      : Text("${projectTitleList[index]}",
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontFamily: "SourceSansPro",
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.grey[800],
                                                      letterSpacing: 0.25,
                                                    ),
                                                  ));
                                            }
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: Height * 5,
                                    width: Width * 100,
                                      margin: EdgeInsets.only(
                                          top: 4, bottom: 8, left: 32, right: 20),
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Ongoing",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: "SourceSansPro",
                                              fontWeight: FontWeight.w800,
                                              color: Colors.grey[800],
                                              letterSpacing: 0.25,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: FlatButton(
                                            child: Text(
                                              "SEE ALL",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "SourceSansPro",
                                                fontWeight: FontWeight.w400,
                                                color: Colors.blueAccent,
                                                letterSpacing: 1.25,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                        ),
                                      ],
                                    )
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      height: Height * 30,
                                      child: PageView.builder(
                                          scrollDirection: Axis.horizontal,
                                          controller: pageViewController,
                                          itemCount: projectTitleList.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              margin: EdgeInsets.only(top: 0, bottom: 4, right: 4, left: 4),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              color: RandomColor().colorRandom(),
                                              elevation: 0,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Material(
                                                    color: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft: Radius.circular(10),
                                                          bottomRight: Radius.circular(10),
                                                        )),
                                                    child: Container(
                                                      width: Width * 100,
                                                      padding: EdgeInsets.only(top: 20, bottom: 20, left: 24),
                                                      alignment: Alignment.bottomLeft,
                                                      child: projectTitleList[index] != null
                                                          ? Text(
                                                        "${projectTitleList[index]}",
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontFamily: "SourceSansPro",
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.grey[800],
                                                          letterSpacing: 0.25,
                                                        ),
                                                        textAlign: TextAlign.left,
                                                      )
                                                          : Text(
                                                        "Null",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: "SourceSansPro",
                                                          fontWeight: FontWeight.w800,
                                                          color: Colors.grey[800],
                                                          letterSpacing: 0.25,
                                                        ),
                                                        textAlign: TextAlign.left,
                                                      ),
                                                    ),
                                                  )

                                                ],
                                              ),
                                            );
                                          }
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              height: 200,
                              child: Column(children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 32),
                                  child: FlatButton(
                                    color: Colors.blue[500],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      "Sign Out",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      _signOut();
                                      final route = SharedAxisPageRoute(
                                          page: LoginPage(),
                                          transitionType:
                                              SharedAxisTransitionType
                                                  .horizontal);
                                      Navigator.of(context)
                                          .pushReplacement(route);
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 32),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    color: Colors.blue[500],
                                    child: Text(
                                      "Check",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      getImage();
                                    },
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: OpenContainer(
                  closedShape: CircleBorder(),
                  closedElevation: 6,
                  transitionDuration: Duration(milliseconds: 500),
                  closedBuilder: (BuildContext c, VoidCallback action) =>
                      Container(
                    width: 56,
                    height: 56,
                    child: FlatButton(
                      color: Colors.deepOrange[100],
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey[800],
                      ),
                      onPressed: () => action(),
                    ),
                  ),
                  openBuilder: (BuildContext c, VoidCallback action) =>
                      NewTask(),
                  tappable: false,
                ),
                drawer: AppDrawer("Home"),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text("No data");
          }
          return AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: Material(
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    alignment: Alignment.center,
                    height: 300,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 50,
                          child: Text(
                            "Loading",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "SourceSansPro",
                              fontWeight: FontWeight.w300,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        CircularProgressIndicator()
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Color get randomColor =>
      Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);

  Future<DocumentSnapshot> userName() async {
    final auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    if (user != null) {
      print(uid);
    }

    return await Firestore.instance
        .collection("users")
        .document(user.uid)
        .get();
  }

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      cropImage(_image);
    });
  }

  Future cropImage(File _image) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            hideBottomControls: true,
            toolbarWidgetColor: Colors.grey[900],
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(() {
      _croppedImage = croppedFile;
      saveImage(_croppedImage);
    });
  }

  Future saveImage(_croppedImage) async {
    //final _savedImage = _croppedImage;

    if (_croppedImage != null) {
      print("ok");
    } else {
      print("nope");
    }

    Directory appDocDir = await getApplicationDocumentsDirectory();
    appDocPath = appDocDir.path;
    print(appDocPath);
    imagePath = ('$appDocPath/profilepic.png');

    if (await File('$appDocPath/profilepic.png').exists()) {
      print("$appDocPath");
      imageCache.evict(FileImage(File(_imagePath)));
    } else {
      print("nope");
    }

    newImage = await _croppedImage.copy('$appDocPath/profilepic.png');

    prefs = await SharedPreferences.getInstance();
    prefs.setString('collImage', newImage.path);
  }

  void loadImage() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('collImage');
    });
  }

  Future checkImage() async {
    if (await File(_imagePath).exists()) {
      print("nice");
    } else {
      print("nope");
    }
  }

  void retrieveProjects() async {

    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("userProjects").document(firebaseUser.uid).get().then((value){
      print(value.data["Projects"]);

      for (int i = 0; i < value.data["Projects"].length; i++) {
        projectTitleList.add(value.data["Projects"][i]);
      }

      print(projectTitleList);
    });


  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _signOut() async {
    await _firebaseAuth.signOut();
    print("signed out");
  }
}

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
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
        leading: Hero(
          tag: "appbar",
          child: ClipOval(
            child: Material(
              color: Colors.white, // button color
              child: InkWell(
                splashColor: Colors.white, // inkwell color
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 20,
                    )),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
        ),
        title: Hero(
            tag: "appbar1",
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SourceSansPro',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: _imagePath != null
                      ? Container(
                          width: 38,
                          height: 38,
                          child: ClipOval(
                              child: Material(
                                  color: Colors.yellow[300],
                                  child: InkWell(
                                      splashColor: Colors.blue[300],
                                      onTap: () {
                                        print(
                                            MediaQuery.of(context).size.width);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(2),
                                          child: CircleAvatar(
                                            backgroundImage:
                                                FileImage(File(_imagePath)),
                                            radius: 100,
                                          ))))),
                        )
                      : Container(
                          width: 38,
                          height: 38,
                          child: Container(
                            child: ClipOval(
                                child: Material(
                                    color: Colors.white,
                                    child: InkWell(
                                        splashColor: Colors.blue[300],
                                        onTap: () {
                                          print(MediaQuery.of(context)
                                              .size
                                              .width);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(2),
                                            child: CircleAvatar(
                                              backgroundImage: newImage != null
                                                  ? FileImage(File(prefs
                                                      .getString('collImage')))
                                                  : NetworkImage(
                                                      'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_account_circle_48px-512.png'),
                                              radius: 100,
                                            ))))),
                          )),
                ),
              ],
            )));
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  final double itemDimension;

  CustomScrollPhysics({this.itemDimension, ScrollPhysics parent})
      : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics(
        itemDimension: itemDimension, parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position) {
    return position.pixels / itemDimension;
  }

  double _getPixels(double page) {
    return page * itemDimension;
  }

  double _getTargetPixels(
      ScrollPosition position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(page.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}

class RandomColor {
  final Color one = Colors.black;
  final Color two = Colors.blue[200];
  final Color three = Colors.deepPurple[200];

  List<Color> hexColor = [Colors.black, Colors.blue[200], Colors.deepPurple[200]];

  static final _random = Random();

  Color colorRandom() {
    return hexColor[_random.nextInt(3)];
  }
}