import 'package:colltest/drawer.dart';
import 'package:colltest/login_view.dart';
import 'package:colltest/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'home_view.dart';
import 'package:animations/animations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        home: LoginPage(),
      ),
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<DrawerStateInfo>(
            create: (_) => DrawerStateInfo()),
      ],
    );
  }
}

class DrawerStateInfo with ChangeNotifier {
  int _currentDrawer = 0;
  int get getCurrentDrawer => _currentDrawer;

  void setCurrentDrawer(int drawer) {
    _currentDrawer = drawer;
    notifyListeners();
  }

  void increment() {
    notifyListeners();
  }
}

class AppDrawer extends StatelessWidget {
  AppDrawer(this.currentPage);

  final String currentPage;

  @override
  Widget build(BuildContext context) {
    var currentDrawer = Provider.of<DrawerStateInfo>(context).getCurrentDrawer;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer'),
            decoration: BoxDecoration(
              color: Colors.lightGreen[300],
            ),
          ),
          ListTile(
              title: Text(
                'Home',
                style: currentDrawer == 0
                    ? TextStyle(fontWeight: FontWeight.bold)
                    : TextStyle(fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.chrome_reader_mode),
              onTap: () {
                Navigator.of(context).pop();
                if (this.currentPage == "Home") return;

                Provider.of<DrawerStateInfo>(context, listen: false)
                    .setCurrentDrawer(0);

                final route = SharedAxisPageRoute(page: Home(), transitionType: SharedAxisTransitionType.horizontal);
                Navigator.of(context).pushReplacement(route);
              }),
          ListTile(
              title: Text(
                'Settings',
                style: currentDrawer == 1
                    ? TextStyle(fontWeight: FontWeight.bold)
                    : TextStyle(fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pop();
                if (this.currentPage == "Settings") return;

                Provider.of<DrawerStateInfo>(context, listen: false)
                    .setCurrentDrawer(1);

                final route = SharedAxisPageRoute(page: Settings(), transitionType: SharedAxisTransitionType.horizontal);
                Navigator.of(context).pushReplacement(route);
              })
        ],
      ),
    );
  }
}

class SharedAxisPageRoute extends PageRouteBuilder {
  SharedAxisPageRoute({Widget page,
  SharedAxisTransitionType transitionType}) : super(
    pageBuilder: (
    BuildContext context,
        Animation<double>primaryAnimation,
        Animation<double>secondaryAnimation,
    ) => page,
    transitionsBuilder: (
    BuildContext context,
        Animation<double> primaryAnimation,
        Animation<double> secondaryAnimation,
        Widget child,
    ){
      return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: transitionType,
          child: child,
      );
    },
  );
}



