import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';


//esta es la pagina donde se muestra la imagen recortada y ejecuta la red neuronal


class ResultPage extends StatefulWidget {
  ResultPage({Key key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  //declara las variables 
  bool _isloading=false;
  File _image;
  List _outputs;

  void initState() {
     _isloading = true;
    super.initState();
    loadModel().then((value){
      setState(() {
        _isloading = false;      
        classifyImage(_image);
      });

    });
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
                                Text("Planta encontrada:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), 
                                SizedBox(width:20),                             
                                _outputs != null 
                              ? Text("${_outputs[0]["label"]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  //fontWeight: FontWeight.w600
                                
                                ),
                              )
                              :Container() 
                              ],

                        ),
                        SizedBox(height:20),
                        RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          onPressed: (){
                            getPosition();
                            Navigator.pushNamed(context, 'about');

                          },
                          color: Color(0xFF06B7A2),
                          child: Text('Leer Mas', style: TextStyle(color: Colors.white)),

                        
                        ),
                      ],

                    ),
                  ),

                 

                ),
              ),

           ]
         ),

       /*   floatingActionButton: FloatingActionButton(
           onPressed:(){
            // classifyImage(_image);
           } ,

           child: Icon(Icons.image)
         ),
 */
        
         
       
    
    );
  }
 //funcion para obtener mi posicion
 getPosition()async {
    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    getAdress();


  }

//funcion para obtener la fecha y hora
 getDatatime(){
   final fecha= DateTime.now();
   print('la fecha');
   
 }


//funcion para obtener el lugar
 getAdress() async {
   final coordinates= new Coordinates(-13.6564672, -73.3826469);

   var direcciones= await Geocoder.local.findAddressesFromCoordinates(coordinates);
   
   print(direcciones.first.featureName);
   print(direcciones.first.addressLine);



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
      _isloading = false;
      _outputs=output;
      
    });


}


}
