import 'package:animations/animations.dart';
import 'package:colltest/home_view.dart';
import 'package:colltest/main.dart';
import 'package:colltest/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  void initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return SafeArea(
        child: Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Container(
                  width: 250,
                  height: 400,
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            //color: Colors.yellow[300],
                            margin: EdgeInsets.only(bottom: 40),
                            width: 300,
                            height: 120,
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontFamily: "SourceSansPro",
                                fontWeight: FontWeight.w900,
                                fontSize: 48,
                              ),
                            )),
                        Material(
                          color: Colors.transparent,
                          child: Container(
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              cursorColor: Colors.yellow[400],
                              controller: emailInputController,
                              keyboardType: TextInputType.emailAddress,
                              validator: emailValidator,
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
                                hintText: 'E-mail',
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
                              margin: EdgeInsets.only(top: 16, bottom: 16),
                              child: TextFormField(
                                cursorColor: Colors.yellow[400],
                                controller: pwdInputController,
                                obscureText: true,
                                validator: pwdValidator,
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
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontFamily: "SourceSansPro",
                                    fontWeight: FontWeight.w300,
                                  ),
                                  focusColor: Colors.yellow[400],
                                ),
                              )),
                        ),
                        ButtonTheme(
                          height: 50,
                          minWidth: 250,
                          child: FlatButton(
                            color: Colors.blue[500],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                fontFamily: "SourceSansPro",
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              signIn();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(bottom: 0, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ButtonTheme(
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          minWidth: 0,
                          height: 0,
                          child: FlatButton(
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.blue[500],
                                fontFamily: "SourceSansPro",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/signup");
                            },
                          )),
                    ],
                  ),
                ),
              )
            ],
          )),
    ));
  }

  void signIn() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser user;

    try {
      user = (await auth.signInWithEmailAndPassword(
        email: emailInputController.text,
        password: pwdInputController.text,
      ))
          .user;
    } catch (e) {
      print((e.toString()));
    } finally {
      if (user != null) {
        final route = SharedAxisPageRoute(
            page: Home(), transitionType: SharedAxisTransitionType.scaled);
        Navigator.of(context).pushReplacement(route);
      } else {
        print("sign in failed!");
      }
    }
  }
}
