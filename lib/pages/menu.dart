//import 'dart:io';
import 'dart:io';

import 'package:MedicPlant/pages/home.dart';
import 'package:MedicPlant/pages/perfil.dart';
import 'package:MedicPlant/pages/plantas.dart';

import 'package:MedicPlant/pages/ubicacion.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _mostrarAlert();
        },
        child: Icon(Icons.camera, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
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
                        icon: Icon(Icons.home, color: Colors.white, size: 36),
                        onPressed: () {
                          if (_pageController.hasClients) {
                            _pageController.animateToPage(0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        }),
                    Text('Inicio', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        icon: Icon(Icons.add_location,
                            color: Colors.white, size: 36),
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
                        icon: Icon(Icons.spa, color: Colors.white, size: 36),
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
                        icon: Icon(Icons.person, color: Colors.white, size: 36),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        alignment: WrapAlignment.start,
                        spacing: 1.0,
                        runSpacing: 1.0,
                        children: [
                          Text('Cámara',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w800)),
                          GestureDetector(
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    color: Theme.of(context).primaryColor),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Image.asset(
                                    "assets/images/camera.png",
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                  ),
                                )),
                            onTap: () {
                              _getImage();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      //-------------galeria------
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        alignment: WrapAlignment.start,
                        spacing: 1.0,
                        runSpacing: 1.0,
                        children: [
                          Text('Galeria',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                          GestureDetector(
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0,
                                      color: Theme.of(context).primaryColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Image.asset(
                                    "assets/images/gallery.png",
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                  ),
                                )),
                            onTap: () {
                              _getGallery();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
