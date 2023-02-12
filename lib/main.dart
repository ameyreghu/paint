import 'package:flutter/material.dart';
import 'package:paint/screens/home.dart';

void main() {
  runApp(const PaintApp());
}

class PaintApp extends StatelessWidget {
  const PaintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
        home: const PaintScreen());
  }
}
