import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Ubicacion extends StatefulWidget {
  Ubicacion({Key key}) : super(key: key);

  @override
  _UbicacionState createState() => _UbicacionState();
}

class _UbicacionState extends State<Ubicacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
        target: LatLng(-13.6564672,-73.3826469),
        zoom:12,
         )
        ),


       
    );
  }
}