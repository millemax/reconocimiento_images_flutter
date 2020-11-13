import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsUbicacion extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String nombre;

  MapsUbicacion(this.latitude, this.longitude, this.nombre);

  @override
  _MapsUbicacionState createState() => _MapsUbicacionState();
}

class _MapsUbicacionState extends State<MapsUbicacion> {
  Set<Marker> markers = new Set<Marker>();

  @override
  void initState() {
    final Marker marker = Marker(
      markerId: new MarkerId('123456'),
      position: LatLng(widget.latitude, widget.longitude),
      infoWindow: InfoWindow(
        title: "Plantas",
        snippet: "chincho",
      ),
    );

    setState(() {
      markers.add(marker);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(this.widget.latitude, this.widget.longitude),
          zoom: 12,
        ),
        markers: markers,
      ),
    );
  }
}
