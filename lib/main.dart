import 'package:flutter/material.dart';
import 'package:MedicPlant/pages/splash.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hola como estas',
      home: Splashscreen(),
      theme: ThemeData(
        primaryColor:Color(0xFF06B7A2),
      ),
        
    );
  }
}