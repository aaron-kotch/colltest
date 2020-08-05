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
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment(0, 0.1),
                child: SizedBox(
                  width: 250,
                  height: 450,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(bottom: 96),
                        child: ClipOval(
                          child: Material(
                            color: Colors.yellow[300],
                            child: Icon(
                              Icons.assignment,
                              color: Colors.blueGrey[800],
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
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'E-mail',
                            hintStyle: TextStyle(
                              fontFamily: "SourceSansPro",
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 16, bottom: 16),
                          child: TextFormField(
                            cursorColor: Colors.yellow[400],
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
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                fontFamily: "SourceSansPro",
                                fontWeight: FontWeight.w300,
                              ),
                              focusColor: Colors.yellow[400],
                            ),
                          )),
                      ButtonTheme(
                        height: 50,
                        minWidth: 250,
                        child: FlatButton(
                          disabledColor: Colors.yellow[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontFamily: "SourceSansPro",
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  padding: EdgeInsets.only(bottom: 16),
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
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, //limits the touch area to the button area
                          minWidth: 0, //wraps child's width
                          height: 0,
                          child: FlatButton(
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.blue[600],
                                fontFamily: "SourceSansPro",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/signup");
                            },
                          )
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
