import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  CameraPage({this.cameras});
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File _image;
  final picker = ImagePicker();
  CameraController _cameraController;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.cameras[0], ResolutionPreset.medium);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF000000),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              CameraPreview(_cameraController),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: double.infinity,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: MarkerPainter(),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'resultpage');
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black),
                              child: Icon(
                                Icons.photo_library,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'resultpage');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.black),
                                child: Icon(
                                  CupertinoIcons.circle_filled,
                                  color: Theme.of(context).primaryColor,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'resultpage');
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black),
                              child: Icon(
                                Icons.flash_on,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //definir el lapiz
    final paint = new Paint()
      ..color = Color(0xFF06B7A2)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    //definir el path
    final path = new Path();
    //esquina superior izquierda
    path.lineTo(0, size.height * 0.3);
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    //esquina superior derecha
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.3);
    path.moveTo(size.width, 0);
    path.lineTo(size.width * 0.7, 0);
    //esquina inferior izquierda
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.7);
    path.moveTo(0, size.height);
    path.lineTo(size.width * 0.3, size.height);
    //esquina inferior derecha
    path.moveTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.7);
    path.moveTo(size.width, size.height);
    path.lineTo(size.width * 0.7, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MarkerPainter oldDelegate) => true;
}
