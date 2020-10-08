import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class DescripcionPlanta extends StatefulWidget {
  @override
  _DescripcionPlantaState createState() => _DescripcionPlantaState();
}

class _DescripcionPlantaState extends State<DescripcionPlanta>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  // variable para construir toda la pagina

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //---recibiendo parametros de home
    final id = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            StreamBuilder<Object>(
                stream: FirebaseFirestore.instance
                    .collection('plantas')
                    .doc(id)
                    .snapshots(),
                builder: (context, snapshot) {
                  DocumentSnapshot data = snapshot.data;
                  return NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          primary: true,
                          floating: true,
                          backgroundColor: Colors.white, //.withOpacity(0.3),
                          snap: true,
                          pinned: false,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            background: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //---------container contenedor de imagen / container redondeado
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(),
                                      height: 290.0,
                                      width: double.infinity,
                                      child: Image.network(
                                        data.data()['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    //----------contenedor redondeado y texto
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 270, bottom: 10),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3.0, color: Colors.white),
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data.data()['nombrecomun'],
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //-----------widget texto / icon  ver en mapa
                              ],
                            ),
                          ),
                          expandedHeight: 380.0,
                          //-------PESTAÑASDENAVEGACION.----
                          bottom: TabBar(
                            indicatorColor: Colors.amber,
                            tabs: [
                              Tab(
                                child: Text(
                                  "Informacion",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Detalles",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                            controller: _tabController,
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        informacion(data),
                        detalles(data),
                      ],
                      controller: _tabController,
                      physics: new NeverScrollableScrollPhysics(),
                    ),
                  );
                }),

            // Here is the AppBar the user actually sees. The SliverAppBar
            // above will slide the TabBar underneath this one.
            // by using SafeArea it will.
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                child: SafeArea(
                  top: false,
                  child: AppBar(
                    backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
                    automaticallyImplyLeading: false,
                    //-----icon leading
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    elevation: 0,
                    title: Text(
                      "Acerca de las Plantas",
                      style: TextStyle(color: Colors.white),
                    ),
                    centerTitle: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//-----------------------------INFORMACION GENERAL ---------
  Widget informacion(data) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10, left: 10, top: 20),
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.spa,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Descripción ",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ],
                ),

                //----Partes utilizables
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.85,
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
                            "Partes utilizables:",
                            style: TextStyle(
                              fontSize: 17,
                              wordSpacing: 2,
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            data.data()['partesutilizables'],
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 17, wordSpacing: 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //---------------Uso medicinal---------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lens,
                                size: 8,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Uso medicinal:",
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
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              data.data()['usomedicinal'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 17, wordSpacing: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //------------------dosis-----------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lens,
                                size: 8,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Dosis:",
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
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              data.data()['dosis'],
                              style: TextStyle(fontSize: 17, wordSpacing: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //------------Contra indicacion ------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lens,
                                size: 8,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Contra indicación:",
                                style: TextStyle(
                                  fontSize: 17,
                                  wordSpacing: 2,
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              data.data()['contraindicacion'],
                              style: TextStyle(fontSize: 17, wordSpacing: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //-----------------planta
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.85,
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
                            "Planta:",
                            style: TextStyle(
                              fontSize: 17,
                              wordSpacing: 2,
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            data.data()['planta'],
                            style: TextStyle(fontSize: 17, wordSpacing: 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//-----------------------------DETALLES GENERALL-------------------
  Widget detalles(data) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 30, left: 30, top: 20),
          child: Container(
            decoration: BoxDecoration(),
            width: MediaQuery.of(context).size.width * 0.9,
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
                            data.data()['familia'],
                            style: TextStyle(fontSize: 17, wordSpacing: 2),
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
                            data.data()['genero'],
                            style: TextStyle(fontSize: 17, wordSpacing: 2),
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
                            data.data()['especie'],
                            style: TextStyle(fontSize: 17, wordSpacing: 2),
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
                            data.data()['nombrecomun'],
                            style: TextStyle(fontSize: 17, wordSpacing: 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
