import 'dart:io';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colltest/login_view.dart';
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
import 'package:carousel_slider/carousel_slider.dart';

File _image;
File _croppedImage;
SharedPreferences prefs;
String appDocPath;
String imagePath;
String _imagePath;
File newImage;

final List<Widget> imgList = [
  Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    color: Colors.blue[500],
  ),
  Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: Colors.blue[500],
  ),
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          top: true,
          child: CustomScrollView(
            slivers: [
              MyAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      height: 250,
                      child: Container(
                        color: Colors.white,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 50,
                              left: 0,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 64, top: 32, bottom: 32),
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Text(
                                      "Hello, ",
                                      style: TextStyle(
                                        fontSize: 34,
                                        fontFamily: 'SourceSansPro',
                                        fontWeight: FontWeight.w900,
                                        color: Colors.grey[800],
                                        letterSpacing: 0.25,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    FutureBuilder(
                                      future: userName(),
                                      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          return Text(snapshot.data.data["username"],
                                            style: TextStyle(
                                              fontSize: 34,
                                              fontFamily: 'SourceSansPro',
                                              fontWeight: FontWeight.w900,
                                              color: Colors.grey[800],
                                              letterSpacing: 0.25,
                                            ),);
                                        } else if (snapshot.connectionState == ConnectionState.none) {
                                          return Text("No data");
                                        }
                                        return CircularProgressIndicator();
                                      },
                                    ),
                                  ],
                                )
                              ),
                            ),
                            Positioned(
                                top: 90,
                                left: 0,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 64, top: 32, bottom: 32),
                                  child: Text(
                                    "Pick up where you've left off",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SourceSansPro',
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey[800],
                                      letterSpacing: 0.25,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 350,
                      color: Colors.white,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          autoPlay: false,
                          viewportFraction: 0.75,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          height: 350,
                        ),
                        items: imageSliders,
                      ),
                    ),
                    Container(
                      height: 200,
                      color: Colors.white,
                      child: Column(
                          children: <Widget> [
                            Container(
                              padding: EdgeInsets.only(top: 32),
                              child: FlatButton(
                                color: Colors.blue[500],
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
                                      transitionType: SharedAxisTransitionType.horizontal);
                                  Navigator.of(context).pushReplacement(route);
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 32),
                              child: FlatButton(
                                color: Colors.blue[500],
                                child: Text(
                                  "Check",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  userName();
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getImage();
          },
          child: Icon(Icons.create),
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey[800],
          elevation: 6,
        ),
        drawer: AppDrawer("Home"),
      ),
    );
  }

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

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _signOut() async {
    await _firebaseAuth.signOut();
    print("signed out");
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            color: Colors.white,
            width: 400,
            child: item,
          ))
      .toList();
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
