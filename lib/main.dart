import 'package:flutter/material.dart';
import 'package:MedicPlant/pages/splash.dart';

import 'pages/login_page.dart';

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
      title: 'hola como estas',
      home: Splashscreen(),
      theme: ThemeData(
        primaryColor: Color(0xFF80E1D1),
      ),
        
    );
  }
}