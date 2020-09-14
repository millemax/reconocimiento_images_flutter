import 'package:MedicPlant/widget/card_widget.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  MyHome({Key key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          primary:true,
          body: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF1F7FB),
            ),

            child: Padding(
              padding: const EdgeInsets.only(bottom: 350),
              child: PageView(
                pageSnapping: false,
                controller: PageController(
                  viewportFraction: 0.4
                ),
                children: [
                  CardWidget('Chincho', 'https://firebasestorage.googleapis.com/v0/b/medicplast-bd.appspot.com/o/DSC_0487-min.JPG?alt=media&token=153c4240-8c7d-4e9d-acb4-c292eb5a16ef'),
                  CardWidget('Atajo','https://firebasestorage.googleapis.com/v0/b/medicplast-bd.appspot.com/o/DSC_0103-min.JPG?alt=media&token=74593bc1-dd2c-49f5-8f3c-d730d2f1bbce'),
                  CardWidget('Matico','https://firebasestorage.googleapis.com/v0/b/medicplast-bd.appspot.com/o/DSC_0348-min.JPG?alt=media&token=d60ae967-f208-43f6-a9e7-0bb8f8f10828')
                ],

              ),
            ),

          ),
          
        
      
       
    );
  }
}