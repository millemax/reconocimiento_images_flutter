import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BusquedaPlantas extends StatefulWidget {
  @override
  _BusquedaPlantasState createState() => _BusquedaPlantasState();
}

class _BusquedaPlantasState extends State<BusquedaPlantas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Buscar"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(context: context, delegate: SearchData());
              })
        ],
      ),
    );
  }
}

class SearchData extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [Text("actions")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Text("leading");
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(
      "Resuts",
      style: TextStyle(color: Colors.red),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text(
      "Suggestions",
      style: TextStyle(color: Colors.red),
    );
  }
}
