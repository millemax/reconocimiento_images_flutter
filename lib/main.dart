import 'package:flutter/material.dart';
import 'package:MedicPlant/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/menu.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: Color(0xFF06B7A2),
        canvasColor: Colors.transparent,
      ),

      routes: {
        '/' :(context,)=>Splashscreen(),
        'menu': (context)=>MenuScreen(),
      },
        
    );
  }
}