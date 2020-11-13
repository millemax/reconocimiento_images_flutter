import 'package:MedicPlant/pages/Aboutplantas/mapsubicacion.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AcercadePlantas extends StatefulWidget {
  final String id;

  AcercadePlantas(this.id);

  @override
  _AcercadePlantasState createState() => _AcercadePlantasState();
}

class _AcercadePlantasState extends State<AcercadePlantas>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  // variable para construir toda la pagina
  String _image = "";
  String _fecha = "";
  String _direccion = "";
  double _latitud;
  double _longitud;
  String _nombre = "";

  bool estado;
  var infoRecuperado = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    estado = false;
    getData(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: estado == false
            ? Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
            : Stack(
                children: <Widget>[
                  NestedScrollView(
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
                                        _image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    //----------contenedor redondeado y texto
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 265, bottom: 10),
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
                                              _nombre,
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //------------widget de informacion inicial
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Fecha de Publicación',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          //------hora de subida y fecha
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.watch_later,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 16.0,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                _fecha,
                                                style:
                                                    TextStyle(fontSize: 14.0),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          //-----fecha de subida de imagen
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 19.0,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  _direccion,
                                                  maxLines: 2,
                                                  style:
                                                      TextStyle(fontSize: 14.0),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: Column(
                                        children: [
                                          Text("Ver planta"),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 1.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                openMapsSheet(context, _latitud,
                                                    _longitud, _nombre);
/*                                                 Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MapsUbicacion(
                                                                _latitud,
                                                                _longitud,
                                                                _nombre))); */
                                              },
                                              child: Image.asset(
                                                "assets/images/mapalocation.png",
                                                scale: 7,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                //-----------widget texto / icon  ver en mapa
                              ],
                            ),
                          ),
                          expandedHeight: 475.0,
                          //-------PESTAÑASDENAVEGACION.----
                          bottom: TabBar(
                            indicatorColor: Colors.amber,
                            tabs: [
                              Tab(
                                child: Text("Informacion",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Tab(
                                child: Text("Detalles",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.amber)),
                              ),
                            ],
                            controller: _tabController,
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        informacionPlantas(infoRecuperado),
                        detallesPlantas(infoRecuperado),
                      ],
                      controller: _tabController,
                      physics: new NeverScrollableScrollPhysics(),
                    ),
                  ),

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
                          //----------icon leading
                          automaticallyImplyLeading: false,
                          leading: GestureDetector(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, 'menu');
                            },
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
  Widget informacionPlantas(List info) {
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
                            info[0]['partesutilizables'],
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
                              info[0]['usomedicinal'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 17, wordSpacing: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //------------Dosis ------

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
                              info[0]['dosis'],
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
                              info[0]['contraindicacion'],
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
                            info[0]['planta'],
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
  Widget detallesPlantas(List detail) {
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
                            detail[0]['familia'],
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
                            detail[0]['genero'],
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
                            detail[0]['especie'],
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
                            detail[0]['nombrecomun'],
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

  //funcion para obtener datos de la base de datos
  getData(id) {
    print('el id del reporte es ' + id);
    FirebaseFirestore.instance
        .collection('reportes')
        .doc(id)
        .get()
        .then((DocumentSnapshot doc) {
      setState(() {
        _image = doc.data()['foto'];
        _nombre = doc.data()['planta'];
        _fecha = doc.data()['fecha'];
        _direccion = doc.data()['direccion'];
        _latitud = doc.data()['latitud'];
        _longitud = doc.data()['longitud'];
      });
      getDatas(_nombre);
    }).catchError((error) {
      print('no pudimos recuperar nada');
    });
  }

  getDatas(nombre) async {
    FirebaseFirestore.instance
        .collection('plantas')
        .where('nombrecomun', isEqualTo: nombre)
        .get()
        .then((value) {
      setState(() {
        estado = true;
      });

      value.docs.forEach((doc) {
        if (value != null) {
          infoRecuperado.clear();
          value.docs.forEach((element) {
            infoRecuperado.add(doc.data());
            print(infoRecuperado);
          });
        }
      });
    });
  }

  //esta es la funcion para mostrar el mapa
  openMapsSheet(context, latitude, longitude, nombre) async {
    try {
      final coords = Coords(latitude, longitude);
      final title = nombre;
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
