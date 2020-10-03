import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//-----
import 'dart:async';
/* import 'users.dart';
import 'services.dart'; */

class SearchPlantas extends StatefulWidget {
  SearchPlantas() : super();

  @override
  _SearchPlantasState createState() => _SearchPlantasState();
}

class _SearchPlantasState extends State<SearchPlantas> {
  //---variable para mostrara por partes de 5
  int _ultimaPlanta = 0;
  List listaPlantas = new List();
//---saber si estamos en el final de las plantas---

  ScrollController _scrollController = new ScrollController();
  //----------------resupera toda la lista------------
  var reportesRecuperado = [];

  List filtroPlantas = new List();
  bool estado = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mostrarCinco();
    getData();

    //-------scrollcontroller
    _scrollController.addListener(() {
      print("scroll !!!");
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _mostrarCinco();
      }
    });
  }

  //---------------------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: estado == false
            ? Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/01.png"),
                      colorFilter: new ColorFilter.mode(
                          Theme.of(context).primaryColor, BlendMode.dstATop),
                      fit: BoxFit.fill,
                    )),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 30,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Buscar",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 20, left: 8, right: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                  ),
                                  fillColor: Theme.of(context).primaryColor,
                                  labelText: "Nombre planta",
                                  hintText: "Nombre planta",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    child: IconTheme(
                                      data: IconThemeData(
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Icon(Icons.search),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: 10,
                                    ),
                                  ),
                                ),
                                onChanged: (string) {},
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  //-----construimos-- aqui lo rescuperado
                  Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(10.0),
                        itemCount: listaPlantas.length,
                        itemBuilder: (BuildContext context, int index) {
                          print("-----------------------------");
                          print(reportesRecuperado);
                          return Card(
                            elevation: 3.0,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  //-------
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Card(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.12,
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              reportesRecuperado[index]['foto'],
                                              scale: 20.0),
                                        ),
                                      ),
                                    ),
                                  ),

                                  //-------------------------aqui..dejo la marca
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //------------
                                      Text(
                                        reportesRecuperado[index]['planta'],
                                        /* filteredUsers[index].name, */
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      //-------------------
                                      Text(
                                        reportesRecuperado[index]['direccion'],
                                        /* filteredUsers[index].email, */
                                        style: TextStyle(
                                            fontSize: 14.0, color: Colors.grey),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
      ),
    );
  }

  //-------------
  getData() async {
    FirebaseFirestore.instance.collection('reportes').get().then((value) {
      setState(() {
        estado = true;
      });

      if (value != null) {
        reportesRecuperado.clear();
        value.docs.forEach((element) {
          reportesRecuperado.add(element.data());
        });
      }
    });
  }

  void _mostrarCinco() {
    for (var i = 0; i < 5; i++) {
      _ultimaPlanta++;
      listaPlantas.add(_ultimaPlanta);
    }
    setState(() {});
  }
}
