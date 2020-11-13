import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Aboutplantas/aboutPlantas_page.dart';
//--waves---
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SearchPlantas extends StatefulWidget {
  SearchPlantas() : super();

  @override
  _SearchPlantasState createState() => _SearchPlantasState();
}

class _SearchPlantasState extends State<SearchPlantas> {
  //-----waves------
  _buildCard({
    Config config,
    Color backgroundColor = Colors.transparent,
  }) {
    return WaveWidget(
      config: config,
      backgroundColor: backgroundColor,
      size: Size(
        double.infinity,
        150.0,
      ),
      waveAmplitude: 0,
    );
  }

  //----------------recupera toda la lista de reportes------------
  var reportesRecuperado = [];

//----lista para almacenar el filtro del reporte
  List filtroPlantas = new List();
  bool estado = false;
  @override
  void initState() {
    //
    super.initState();
    filtroPlantas = reportesRecuperado;
    getData();
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
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Image.asset("assets/images/loadi.gif")),
                ),
              )
            : Stack(
                children: [
                  titulo(),
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 8.0, left: 8.0, right: 8.0, bottom: 20.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                fontSize: 13,
                              ),
                              fillColor: Theme.of(context).primaryColor,
                              labelText: "Nombre planta",
                              hintText: "Nombre planta",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
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
                                      color: Theme.of(context).primaryColor),
                                  child: Icon(Icons.search),
                                ),
                                padding: EdgeInsets.only(
                                  left: 10,
                                ),
                              ),
                            ),
                            onChanged: (string) {
                              print("********************************++++");
                              print(reportesRecuperado[0]['planta']);
                              setState(() {
                                filtroPlantas = reportesRecuperado
                                    .where(
                                      (r) => (r['planta']
                                          .toString()
                                          .toLowerCase()
                                          .contains(string.toLowerCase())),
                                    )
                                    .toList();
                              });
                            },
                          ),
                        ),
                        //-----construimos-- aqui lo rescuperado
                        Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.only(right: 10.0, left: 10.0),
                              itemCount: filtroPlantas.length,
                              itemBuilder: (BuildContext context, int index) {
                                print("-----------------------------");
                                print(reportesRecuperado);
                                return GestureDetector(
                                  child: Card(
                                    elevation: 3.0,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          //-------
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Card(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.08,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.12,
                                                child: Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      reportesRecuperado[index]
                                                          ['foto'],
                                                      scale: 20.0),
                                                ),
                                              ),
                                            ),
                                          ),

                                          //-------------------------aqui..dejo la marca
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //------------
                                              Text(
                                                filtroPlantas[index]['planta'],
                                                /* filteredUsers[index].name, */
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              //-------------------
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.65,
                                                child: Text(
                                                  filtroPlantas[index]
                                                      ['direccion'],
                                                  /* filteredUsers[index].email, */
                                                  style: TextStyle(
                                                      fontSize: 10.0,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AcercadePlantas(
                                                    filtroPlantas[index]
                                                        ['iud'])));
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  //----------
  //----encabezado de la pagina ---
  Widget titulo() {
    return Container(
      child: Stack(
        children: [
          _buildCard(
            config: CustomConfig(
              colors: [
                Colors.white70,
                Colors.white54,
                Colors.white30,
                Colors.white,
              ],
              durations: [32000, 21000, 18000, 5000],
              heightPercentages: [0.31, 0.35, 0.40, 0.41],
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //----WIDGET REGRESO A PERFIL VETERINARIA---
              Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                runSpacing: 1.0,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 18,
                    ),
                  ),
                ],
              ),
              //----TITULO DE LA SECCION---
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  right: 150,
                ),
                child: Text(
                  "Buscar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
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
}
