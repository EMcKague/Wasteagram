import 'package:flutter/material.dart';
import 'package:wastegram/screens/details_screen.dart';
import 'package:wastegram/screens/home_screen.dart';
import 'package:wastegram/screens/new_post_screen.dart';

class MyApp extends StatelessWidget {
  static final routes = {
    'homeScreen': (context) => homeScreen(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
          primaryColor: Colors.blueGrey,
          brightness: Brightness.dark,
          primarySwatch: Colors.green),
      home: homeScreen(),
      routes: routes,
    );
  }
}
