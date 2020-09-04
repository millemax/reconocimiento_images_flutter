import 'dart:async';
//import 'package:MedicPlant/pages/detect_screen.dart';
import 'package:MedicPlant/pages/login_page.dart';
//import 'package:MedicPlant/pages/menu.dart';
import 'package:flutter/material.dart';
//import 'login_page.dart';



class Splashscreen extends StatefulWidget {
  Splashscreen({Key key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds:8), ()=> Navigator.push(context,MaterialPageRoute(builder:(context)=> LoginPage())));
    //Timer(Duration(seconds:8), ()=> Navigator.push(context,MaterialPageRoute(builder:(context)=> DetectScreen())));
        
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.green,
          padding: EdgeInsets.only(top: 250),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Image.asset('assets/images/Medicplant.gif', height: 300), 
              SizedBox(height:20),
             // Text('Medic Plant', style: TextStyle(color: Colors.white)),
              
            ],
          ),
        ),
      


      

       
    );
  }
}


