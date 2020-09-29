import 'package:flutter/material.dart';

class Plantas extends StatefulWidget {
  Plantas({Key key}) : super(key: key);

  @override
  _PlantasState createState() => _PlantasState();
}

class _PlantasState extends State<Plantas> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Buscar plantas",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {})
            ],
          ),
          body: Center(
              child: Image.asset(
            "assets/images/planta.png",
            scale: 3,
          ))),
    );
  }
}

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // acciones para la barra de aplicaciones
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {})];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono principal a la izquierda de la barra de aplicaciones
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // mostrar algun resultado basado en la seleccion
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // mostrar cuando alguien busca algo
    throw UnimplementedError();
  }
}
