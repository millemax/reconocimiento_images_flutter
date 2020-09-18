import 'package:flutter/material.dart';

class DetallesPlantas extends StatelessWidget {
  const DetallesPlantas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 30, left: 30, top: 20),
                child: Container(
                  decoration: BoxDecoration(),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //-----icon y titulo----clasificacion cientifica--954081013
                      Row(
                        children: [
                          Icon(
                            Icons.school,
                            color: Theme.of(context).primaryColor,
                            size: 22,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Clasificación Científica",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      //----Familia
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 15, bottom: 10),
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lens,
                                  size: 8,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Familia:",
                                  style: TextStyle(
                                    fontSize: 17,
                                    wordSpacing: 2,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Iridacae",
                                  style:
                                      TextStyle(fontSize: 17, wordSpacing: 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //-----------Genero--

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lens,
                                  size: 8,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Género:",
                                  style: TextStyle(
                                    fontSize: 17,
                                    wordSpacing: 2,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Iridacae",
                                  style:
                                      TextStyle(fontSize: 17, wordSpacing: 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //-----------ESpecie---

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 15, bottom: 10),
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lens,
                                  size: 8,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Especie:",
                                  style: TextStyle(
                                    fontSize: 17,
                                    wordSpacing: 2,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Iridacae",
                                  style:
                                      TextStyle(fontSize: 17, wordSpacing: 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //-------------------clasificacion cientifica--
                      //-----Nombre comun-------------
                      Row(
                        children: [
                          Icon(
                            Icons.art_track,
                            color: Theme.of(context).primaryColor,
                            size: 25,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Nombre común",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 15, bottom: 10),
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lens,
                                  size: 8,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 5),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Iridacae",
                                  style:
                                      TextStyle(fontSize: 17, wordSpacing: 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //-------------------fin nombre comun--
                      //-----icon y titulo----uso de la planta--
                      Row(
                        children: [
                          Icon(
                            Icons.comment,
                            color: Theme.of(context).primaryColor,
                            size: 17,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Uso",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      //----texto
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            decoration: BoxDecoration(),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit\n",
                              style: TextStyle(fontSize: 17, wordSpacing: 2),
                            ),
                          ),
                        ],
                      )
                      //-------------------fin usos de la planta--
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
