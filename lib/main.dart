import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() {
  runApp(PlantApp());
}

class PlantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planta Medic',
      home: LoginPage(),

      //-----EL THEMA ---
      theme: ThemeData(
        primaryColor: Color(0xFF06B7A2),
        canvasColor: Colors.transparent,
      ),
    );
  }
}
