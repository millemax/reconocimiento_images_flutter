import 'dart:io';
import 'package:MedicPlant/pages/Aboutplantas/aboutPlantas_page.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_dialog/progress_dialog.dart';

//esta es la pagina donde se muestra la imagen recortada y ejecuta la red neuronal

class ResultPage extends StatefulWidget {
  ResultPage({Key key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  //----bottom al enviar y guardar las platnas
  bool buttonPressed = true;

  void _letsPressed() {
    setState(() {
      buttonPressed = !buttonPressed;
    });
  }
//---------

  ProgressDialog progressDialog;

  //declara las variables
  bool _isloading = false;
  File _image;
  List _outputs;
  double _percent;

  //varibles para enviar a la base de datos
  double _latitud;
  double _longitud;
  String _fecha;
  String _direccion;

  @override
  void initState() {
    _isloading = true;
    loadModel().then((value) {
      setState(() {
        _isloading = false;
        classifyImage(_image);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageFile = ModalRoute.of(context).settings.arguments;
    _image = File(imageFile);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Resultado", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: _isloading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.93,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: _image == null
                        ? Container()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.31,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber),
                        /* color: Theme.of(context).primaryColor.withOpacity(0.3), */
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _outputs != null
                                  ? Column(
                                      children: [
                                        Text(
                                          "${_outputs[0]["label"].toUpperCase()}",
                                          style: TextStyle(
                                              letterSpacing: 2,
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.06,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    )
                                  : Text('.'),
                            ],
                          ),

                          /*
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {
                                getPosition();
                              },
                              color: Color(0xFF06B7A2),
                              child: Text('Guardar y leer mas',
                                  style: TextStyle(color: Colors.white)),
                            ), */
                          SizedBox(height: 12),
                          Text('Guardar',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _letsPressed();
                              getPosition();
                            },
                            child: buttonPressed ? myButton() : buttonTapped(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

//------------------------------------boton GUARDAR PLANTA----------------
  /*  Widget buttonTapped() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        /*  borderRadius: BorderRadius.circular(10.0), */
        shape: BoxShape.circle,
        color: Colors.amber,
        boxShadow: [
          BoxShadow(
              color: Colors.white,
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
          BoxShadow(
              color: Colors.grey[600],
              offset: Offset(-4.0, -4.0),
              blurRadius: 10.0,
              spreadRadius: 1.0)
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[700],
            Colors.grey[600],
            Colors.grey[500],
            Colors.grey[200],
          ],
          stops: [0, 0.1, 0.3, 1],
        ),
      ),
      child: Image.asset(
        "assets/images/archivoo.png",
        scale: 6,
      ),
    );
  } */

  Widget buttonTapped() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Image.asset("assets/images/gofo.gif"),
    );
  }

  Widget myButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        /*  borderRadius: BorderRadius.circular(10.0), */
        shape: BoxShape.circle,
        color: Colors.amber,
        boxShadow: [
          BoxShadow(
              color: Colors.grey[600],
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0)
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[200],
            Colors.grey[300],
            Colors.grey[400],
            Colors.grey[500],
          ],
          stops: [0.1, 0.3, 0.8, 1],
        ),
      ),
      child: Image.asset(
        "assets/images/archivoo.png",
        scale: 6,
      ),
    );
  }

  //funcion para obtener mi posicion
  getPosition() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      _latitud = position.latitude;
      _longitud = position.longitude;
    });

    getAdress(position.latitude, position.longitude);
  }

//funcion para obtener el lugar
  getAdress(double lat, double long) async {
    final coordinates = new Coordinates(lat, long);
    var direcciones =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    // print(direcciones.first.featureName);
    print(direcciones.first.addressLine);

    setState(() {
      _direccion = direcciones.first.addressLine;
    });

    getDatatime();
  }

  //funcion para obtener la fecha y hora
  getDatatime() {
    final fecha = DateTime.now();
    final formateado = DateFormat().add_yMd().add_jm().format(fecha);
    print(formateado);
    setState(() {
      _fecha = formateado;
    });

    uploadImage();
  }

  //cargamos la imagen a la base de datos
  //funcion para cargar la imagen a firestore y recuerar la url
  uploadImage() async {
    final StorageReference postImgRef =
        FirebaseStorage.instance.ref().child('plantas');
    var timeKey = DateTime.now();

    //carguemos a storage
    final StorageUploadTask uploadTask =
        postImgRef.child(timeKey.toString() + ".png").putFile(_image);

    // recuperamos la  url esperamos que termine de cargar
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    final String url = imageUrl.toString();

    saveData(url);
  }

  //funcion para cargar a la base de datos
  saveData(url) {
    //inicializando el progressDialog
    //el progresdialog
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: 'cargando..');
    progressDialog.show();

    final String id = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('reportes').add({
      'usuario': id,
      'foto': url,
      'latitud': _latitud,
      'longitud': _longitud,
      'direccion': _direccion,
      'planta': _outputs[0]["label"],
      'fecha': _fecha,
    }).then((resp) {
      print(resp.id);
      FirebaseFirestore.instance
          .collection('reportes')
          .doc(resp.id)
          .update({'iud': resp.id}).then((value) {
        progressDialog.hide();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AcercadePlantas(resp.id)));
      });
    }).catchError((error) {
      print('error no se pudo cargar a la base de datos');
      progressDialog.hide();
    });
  }

  //funcion que carga el modelo tflite
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/tflite/model_unquant.tflite",
      labels: "assets/tflite/labels.txt",
    );

    print("modelo cargado ........");
  }

  //clasificador de la imagen
  classifyImage(image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _percent = output[0]["confidence"] * 100;

      if (_percent >= 99.8) {
        _isloading = false;
        _outputs = output;
      } else {
        alert();
      }
    });
    print("******************************holapercents");
    print(_percent);
  }

//mensaje de alerta que enviara cuando no reconozca una planta
  alert() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(
                "LO SIENTO !!",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              content: new Text(
                  "Todavia no estoy preparado para reconocer esta planta!"),
              actions: <Widget>[
                /* FlatButton(
                  child: Text('volver'),
                  onPressed: () {
                    setState(() {
                      _image = null;
                      _outputs = null;
                      _isloading = false;
                      _percent = null;
                    });
                    Navigator.pushNamed(context, 'menu');
                  },
                ) */
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Theme.of(context).primaryColor),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 143, vertical: 10),
                        child: Text("volver"),
                      )),
                  onTap: () {
                    setState(() {
                      _image = null;
                      _outputs = null;
                      _isloading = false;
                      _percent = null;
                    });
                    Navigator.pushNamed(context, 'menu');
                  },
                )
              ],
            ));
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
    _image.delete();
    _outputs.clear();
  }
}
