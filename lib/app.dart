import 'package:flutter/material.dart';
import 'package:wastegram/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
          primaryColor: Colors.blueGrey,
          brightness: Brightness.dark,
          primarySwatch: Colors.green),
      home: homeScreen(title: 'Wasteagram'),
    );
  }
}
