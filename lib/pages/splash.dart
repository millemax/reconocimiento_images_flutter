import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';



class Splashscreen extends StatefulWidget {
  Splashscreen({Key key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds:5), ()=> Navigator.push(context,MaterialPageRoute(builder:(context)=> LoginPage())));
        
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.green[500],
          padding: EdgeInsets.only(top: 250),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Image.asset('assets/images/logoblanco.png', height: 150), 
              SizedBox(height:20),
              Text('Medic Plant', style: TextStyle(color: Colors.white)),
              
            ],
          ),
        ),
      


      

       
    );
  }
}


