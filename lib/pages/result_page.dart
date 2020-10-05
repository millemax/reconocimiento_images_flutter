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
  ProgressDialog progressDialog;


  //declara las variables 
  bool _isloading=false;
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
      loadModel().then((value){
      setState(() {
        _isloading = false;      
        classifyImage(_image);
      });

    });
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {

    

    final  imageFile= ModalRoute.of(context).settings.arguments;
    _image= File(imageFile);
    
  

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Respuesta", style: TextStyle(color: Colors.white)),
      ),
      body:_isloading 
         ? Container(
           alignment: Alignment.center,
           child: CircularProgressIndicator(),
         )

         :Stack(
             children:[
              Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: _image == null ? Container(): Image.file(_image, fit: BoxFit.fill,)
                  ),

              Padding(
                padding: const EdgeInsets.only(top:500),
                child: Container(  
                  width: MediaQuery.of(context).size.width,              
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical:40),
                    child: Column(
                      children: [
                        
                        Row(
                           
                              children: [
                                Text("Planta:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), 
                                SizedBox(width:20),                             
                                _outputs != null 
                              ? Text("${_outputs[0]["label"]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  //fontWeight: FontWeight.w600
                                
                                ),
                              )
                              :Text('No puedo reconocerlo', maxLines:2),
                              ],

                        ),
                        SizedBox(height:20),
                        RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          onPressed: (){
                            getPosition();
                            

                          },
                          color: Color(0xFF06B7A2),
                          child: Text('Guardar y leer mas', style: TextStyle(color: Colors.white)),

                        
                        ),
                      ],

                    ),
                  ),

                 

                ),
              ),

           ]
         ),

     
         
       
    
    );
  }
 //funcion para obtener mi posicion
 getPosition()async {
    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      _latitud= position.latitude;
      _longitud= position.longitude;
    });


    getAdress(position.latitude, position.longitude);    
    


  }




//funcion para obtener el lugar
 getAdress(double lat,double long) async {
   final coordinates= new Coordinates(lat, long);
   var direcciones= await Geocoder.local.findAddressesFromCoordinates(coordinates);
   
   // print(direcciones.first.featureName);
   print(direcciones.first.addressLine);

   setState(() {
     _direccion=direcciones.first.addressLine;
   });

   getDatatime();

 }

 //funcion para obtener la fecha y hora
 getDatatime(){
   final fecha= DateTime.now();   
   final formateado= DateFormat().add_yMd().add_jm().format(fecha);
   print(formateado);
   setState(() {
     _fecha= formateado;
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
 saveData(url){
   //inicializando el progressDialog
   //el progresdialog
     progressDialog = ProgressDialog(context,type: ProgressDialogType.Normal);
    progressDialog.style(message: 'cargando..');
    progressDialog.show(); 



   final String id = FirebaseAuth.instance.currentUser.uid;
   FirebaseFirestore.instance.collection('reportes').add({
     'usuario': id,
     'foto': url,
     'latitud': _latitud,
     'longitud': _longitud,
     'direccion': _direccion,
     'planta':_outputs[0]["label"],
     'fecha':_fecha,


     
   }).then((value){
      
      //Navigator.pushNamed(context, 'about', arguments: value.id);
      print('exito cargado');
       progressDialog.hide(); 
      Navigator.push(context,
       MaterialPageRoute(builder:(context)=> AcercadePlantas(value.id)));

     

   }).catchError((error){
     
     print('error no se pudo cargar a la base de datos');
     progressDialog.hide();

   });



 }






  //funcion que carga el modelo tflite
  loadModel() async {
    await Tflite.loadModel(
      model:"assets/tflite/model_unquant.tflite",
      labels: "assets/tflite/labels.txt",

    );

    print("modelo cargado ........");


  }


  //clasificador de la imagen 
  classifyImage(image) async {
    var output= await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean:127.5,
      imageStd: 127.5,  
    );
    setState(() {
      
      _percent= output[0]["confidence"]*100;

      if (_percent >=99.8) {
        _isloading = false;
        _outputs=output;

        
      } else {
        alert();

      }
      
    });

    print(_percent);
}

//mensaje de alerta que enviara cuando no reconozca una planta 
alert(){

     showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("LO SIENTO !!"),
              content: new Text("Todavia no estoy preparado para reconocer estas plantas!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('volver'),
                  onPressed: () {
                    setState(() {
                        _image=null;
                        _outputs=null;
                        _isloading=false;
                        _percent= null;
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
