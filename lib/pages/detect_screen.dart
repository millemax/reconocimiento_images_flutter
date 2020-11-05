import 'package:MedicPlant/helpers/camera_helper.dart';
import 'package:MedicPlant/helpers/tflite_helper.dart';
import 'package:MedicPlant/models/result.dart';
import 'package:flutter/material.dart';

class DetectScreen extends StatefulWidget {
  DetectScreen({Key key}) : super(key: key);

  @override
  _DetectScreenState createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen>
    with TickerProviderStateMixin {
  AnimationController _colorAnimController;
  Animation _colorTween;

  List<Result> outputs;

//inicializamos  con esta funcion
  void initState() {
    super.initState();

    //cargar el modelo tensorflow lite
    TFLiteHelper.loadModel().then((value) {
      setState(() {
        TFLiteHelper.modelLoaded = true;
      });
    });

    //inicializamos la camara

    CameraHelper.initializeCamera();

    //preparar animation
    _setupAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _setupAnimation() {
    _colorAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _colorTween = ColorTween(begin: Colors.green, end: Colors.red)
        .animate(_colorAnimController);
  }
}
