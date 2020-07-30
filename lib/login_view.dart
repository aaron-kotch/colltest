import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.lime[300],
              child: Container(
                alignment: Alignment(0,0.1),
                child: SizedBox(
                  width: 250,
                  height: 400,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(bottom: 96),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white,
                            child: Icon(
                              Icons.assignment,
                              color: Colors.cyan[800],
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          cursorColor: Colors.yellow[400],
                          style: TextStyle(
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[200],
                                ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[200],
                                ),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            hintText:'E-mail',
                            hintStyle: TextStyle(
                              fontFamily: "SourceSansPro",
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: TextFormField(
                          cursorColor: Colors.yellow[400],
                          style: TextStyle(
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[200],
                                ),
                                borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[200],
                                ),
                                borderRadius: BorderRadius.circular(10),
                            ),
                            hintText:'Password',
                            hintStyle: TextStyle(
                              fontFamily: "SourceSansPro",
                              fontWeight: FontWeight.w300,
                            ),
                            focusColor: Colors.yellow[400],
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),
        ),
    );
  }
}
