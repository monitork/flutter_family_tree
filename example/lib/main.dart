import 'package:flutter/material.dart';
//import 'package:flutter_family_tree/flutter_family_tree.dart';
import 'package:flutter_family_tree_example/ui/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
