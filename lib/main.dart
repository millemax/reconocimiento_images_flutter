import 'package:MedicPlant/pages/Aboutplantas/aboutPlantas_page.dart';
import 'package:MedicPlant/pages/camera_page.dart';
import 'package:MedicPlant/pages/login_page.dart';

import 'package:MedicPlant/pages/result_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:MedicPlant/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (_) => ThemeChanger(ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFF06B7A2),
          backgroundColor: Colors.white)),
      child: MaterialAppTheme(),
    );
  }
}

class MaterialAppTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      theme: theme.getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Medic Plant',
      initialRoute: '/',
      routes: {
        '/': (context) => Splashscreen(),
        'menu': (context) => MenuScreen(),
        'resultpage': (context) => ResultPage(),
        'camerapage': (context) => CameraPage(
              cameras: cameras,
            ),
        'about': (context) => AcercadePlantas(),
        'login': (context) => LoginPage(),
      },
    );
  }
}

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;
  ThemeChanger(this._themeData);
  getTheme() => _themeData;
  setTheme(ThemeData theme) {
    this._themeData = theme;
    notifyListeners();
  }
}
