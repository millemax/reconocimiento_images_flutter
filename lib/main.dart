import 'package:MedicPlant/pages/Description.dart';
import 'package:MedicPlant/pages/camera_page.dart';
import 'package:MedicPlant/pages/home.dart';
import 'package:MedicPlant/pages/login_page.dart';
import 'package:MedicPlant/pages/result_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:MedicPlant/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/menu.dart';

List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
      title: 'Medic Plant',
      initialRoute: '/',
      theme: ThemeData(
        /* primaryColor: Color(0xFF06B7A2), */
        primaryColor: Color(0xff009688),
        canvasColor: Colors.transparent,
        primaryColorDark: Color(0XFFbe98d0),
        fontFamily: 'comforta',
      ),
      routes: {
        '/': (context) => LoginPage(),
        'menu': (context) => MenuScreen(),
        'resultpage': (context) => ResultPage(),
        'camerapage': (context) => CameraPage(
              cameras: cameras,
            ),
        'login': (context) => LoginPage(),
        'DescripcionPlanta': (context) => DescripcionPlanta(),
        'MyHome': (context) => MyHome(),
      },
    );
  }
}
