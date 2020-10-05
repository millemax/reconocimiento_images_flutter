//import 'dart:io';
import 'dart:io';

import 'package:MedicPlant/pages/home.dart';
import 'package:MedicPlant/pages/perfil.dart';
import 'package:MedicPlant/pages/plantas.dart';

import 'package:MedicPlant/pages/ubicacion.dart';
import 'package:flutter/material.dart';

import 'Aboutplantas/prueba.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  PageController _pageController;

  //variables para la camara
  File _image;
  final picker = ImagePicker();

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

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
    print('esta es la ruta :' + pickedFile.path);
    _cropImage(pickedFile);
  }

  Future _getGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
    print('esta es la ruta :' + pickedFile.path);
    _cropImage(pickedFile);
  }

  Future _cropImage(PickedFile image) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Recortar',
            toolbarColor: Color(0xFF06B7A2),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Recortar',
        ));

    if (croppedFile != null) {
      _image = croppedFile;
      print("ruta del recortado :" + _image.path);
      Navigator.pushNamed(context, 'resultpage', arguments: _image.path);
    }
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
          Container(child: SearchPlantas()),
          Container(child: Perfil()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF06B7A2),
        onPressed: () {
          _mostrarAlert();
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

  alerta() {
    AlertDialog();
  }

  //muestra la el alert para dar la aopcion de elegir entre camara o galleria
  void _mostrarAlert() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.only(top: 2),
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
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlatButton.icon(
                  color: Color(0xFF06B7A2),
                  onPressed: () {
                    _getGallery();
                    Navigator.of(context).pop();
                  },
                  label: Text('Galeria', style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.add_photo_alternate, color: Colors.white),
                ),
                SizedBox(
                  width: 20,
                ),
                FlatButton.icon(
                  color: Color(0xFF06B7A2),
                  onPressed: () {
                    _getImage();
                    Navigator.of(context).pop();
                  },
                  label: Text('Cámara', style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                ),
              ],
            ),
          );
        });
  }
}
