//import 'dart:io';
import 'package:MedicPlant/pages/home.dart';
import 'package:MedicPlant/pages/perfil.dart';
import 'package:MedicPlant/pages/plantas.dart';

import 'package:MedicPlant/pages/ubicacion.dart';
import 'package:flutter/material.dart';

import 'Aboutplantas/prueba.dart';
//import 'package:image_picker/image_picker.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: [
          Container(child: MyHome()),
          Container(child: Ubicacion()),
          Container(child: BusquedaPlantas()),
          Container(child: Perfil()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF06B7A2),
        onPressed: () {
          Navigator.pushNamed(context, 'camerapage');
        },
        child: Icon(Icons.camera, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF06B7A2),
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    IconButton(
                        icon: Icon(Icons.home, color: Colors.white, size: 40),
                        onPressed: () {
                          if (_pageController.hasClients) {
                            _pageController.animateToPage(0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        }),
                    Text('  Home', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        icon: Icon(Icons.add_location,
                            color: Colors.white, size: 40),
                        onPressed: () {
                          if (_pageController.hasClients) {
                            _pageController.animateToPage(1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        }),
                    Text('  Ubicacion', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox.shrink(),
                Column(
                  children: [
                    IconButton(
                        icon: Icon(Icons.spa, color: Colors.white, size: 40),
                        onPressed: () {
                          if (_pageController.hasClients) {
                            _pageController.animateToPage(2,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        }),
                    Text('  Plantas', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        icon: Icon(Icons.person, color: Colors.white, size: 40),
                        onPressed: () {
                          if (_pageController.hasClients) {
                            _pageController.animateToPage(3,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        }),
                    Text('  Perfil', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarAlert() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlatButton.icon(
                    color: Colors.amber,
                    onPressed: () {},
                    label: Text('Galeria'),
                    icon: Icon(Icons.add_photo_alternate)),
                FlatButton.icon(
                    color: Colors.amber,
                    onPressed: () {
                      Navigator.pushNamed(context, 'camerapage');
                    },
                    label: Text('Cámara'),
                    icon: Icon(Icons.camera_alt))
              ],
            ),
          );
        });
  }
}
