import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';

import 'package:MedicPlant/pages/Aboutplantas/aboutPlantas_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:path_provider/path_provider.dart';
//import 'dart:math';
import 'package:http/http.dart' as http;




class Ubicacion extends StatefulWidget {
  Ubicacion({Key key}) : super(key: key);

  @override
  _UbicacionState createState() => _UbicacionState();
}

class _UbicacionState extends State<Ubicacion> {

  

  Set<Marker> markers= new Set<Marker>();

  double _latitud;
  double _longitud;
  bool estado= false;

  @override
  void initState() { 
    getPosition();
    getData();    
    super.initState();
    
  }

  

  main(String urlimage, String nombrePlanta, double latitud, double longitud, String id) async {
    
    var file= await urlToFile(urlimage);      
    await adMarker(file, nombrePlanta, latitud, longitud, id); 
  

}

  getData(){
    FirebaseFirestore.instance.collection('reportes').get().then((QuerySnapshot querySnapshot){
      
      querySnapshot.docs.forEach((doc){
        print(doc.data()['direccion']);
        main(doc.data()['foto'], doc.data()['planta'], doc.data()['latitud'], doc.data()['longitud'], doc.id);
         
      });
      

    }).catchError((err){

    });

  }

    //funcion para obtener mi posicion
  getPosition() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      _latitud = position.latitude;
      _longitud = position.longitude; 
      estado=true;      
    });

    
  }


  adMarker(File image, String nombreplanta, double latitud, double longitud, String id) async {
    print('este es la ruta de la imagen :'+ image.path);
    var rng = DateTime.now().millisecondsSinceEpoch;
    final Marker marker= Marker(
    icon:  await getMarkerIcon(image, Size(150.0, 150.0)),                                           /* await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(24, 24)), 'assets/images/gps.png'),  */   
    markerId: new MarkerId(rng.toString()),
    position: LatLng(latitud,longitud),    
    infoWindow: InfoWindow(
      title: "Planta",
      snippet: nombreplanta, 
      onTap: (){
        print('enviando el id:'+ id);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AcercadePlantas(id)));
      },     
    ),
  );
    if (this.mounted) {
       setState(() {
      markers.add(marker);
    });
      
    }
    

  
  }

  

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:estado== false?Container(
          child: Center(
            child: Image.asset('assets/images/loadi.gif', scale: 3),
          ),
        ) 
        :GoogleMap(
            initialCameraPosition: CameraPosition(
          target: LatLng(_latitud,_longitud),
          zoom: 12,
          
        ),
        markers:markers,
        
        ),
      ),
    );
  }

  Future<BitmapDescriptor> getMarkerIcon(File imagefile, Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint tagPaint = Paint()..color = Colors.blue;
    final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = Colors.green[200];
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              0.0,
              0.0,
              size.width,
              size.height
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              shadowWidth,
              shadowWidth,
              size.width - (shadowWidth * 2),
              size.height - (shadowWidth * 2)
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Add tag circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              size.width - tagWidth,
              0.0,
              tagWidth,
              tagWidth
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        tagPaint);

    // Add tag text
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: '1',
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );

    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(
            size.width - tagWidth / 2 - textPainter.width / 2,
            tagWidth / 2 - textPainter.height / 2
        )
    );

    // Oval for the image
    Rect oval = Rect.fromLTWH(
        imageOffset,
        imageOffset,
        size.width - (imageOffset * 2),
        size.height - (imageOffset * 2)
    );

    // Add path for oval image
    canvas.clipPath(Path()
      ..addOval(oval));

   
    ui.Image image = await loadUiImage(imagefile); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.cover);
 
    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
        size.width.toInt(),
        size.height.toInt()
    );

    // Convert image to bytes
    final ByteData byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
}




//funcion que convierte la imagen en bits para dibujar en un lienzo
Future<ui.Image> loadUiImage(File imagefile) async {
  print('la ruta de la imagen que va ha procesar: '+ imagefile.path);
  final  data = imagefile.readAsBytesSync(); 
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}



// funcion de obtiene imagene a apartir de la url http
Future<File> urlToFile(String imageUrl) async {

var rng = DateTime.now().microsecondsSinceEpoch;
print('los miliseconds' + rng.toString());

Directory tempDir = await getTemporaryDirectory();

String tempPath = tempDir.path;

File file = new File('$tempPath'+ rng.toString() +'.png');

http.Response response = await http.get(imageUrl);

await file.writeAsBytes(response.bodyBytes);



return file;



}










}
