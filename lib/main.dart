import 'package:flutter/material.dart';
import 'package:system/Dashboard.dart';
import 'package:system/Test.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AttendanceApp(),
    );
  }
}
