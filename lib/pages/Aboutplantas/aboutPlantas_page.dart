import 'package:MedicPlant/pages/Aboutplantas/detallesPlantas_page.dart';
import 'package:MedicPlant/pages/Aboutplantas/mapsubicacion.dart';
import 'package:flutter/material.dart';
import 'package:MedicPlant/pages/Aboutplantas/informacionPlanta_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String _image="";
  String _fecha="";
  String _direccion="";
  double _latitud;
  double _longitud;
  String _nombre="";

  bool estado;



  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
     estado=false;
      getData(widget.id);

    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {  
    
    return Scaffold(
      body: SafeArea(
        child: estado==false? Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          )
        ): Stack(
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
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 3.0, color: Colors.white),
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fecha de Publicación',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Theme.of(context).primaryColor,
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
                                          color: Theme.of(context).primaryColor,
                                          size: 16.0,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          _fecha,
                                          style: TextStyle(fontSize: 14.0),
                                          textAlign: TextAlign.left,
                                        ),
                                        /* Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text("Ver planta en mapa"),
                                        ) */
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
                                          color: Theme.of(context).primaryColor,
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
                                            style: TextStyle(fontSize: 14.0),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        /* Padding(
                                          padding:
                                              const EdgeInsets.only(left: 1.0),
                                          child: Image.asset(
                                            "assets/images/mapalocation.png",
                                            scale: 7,
                                          ),
                                        ), */
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Column(
                                  children: [
                                    Text("Ver planta"),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1.0),
                                      child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                MaterialPageRoute(builder:(context)=>MapsUbicacion(_latitud, _longitud))
                                               );
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
                    expandedHeight: 460.0,
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
                  InformacionPlantas(),
                  DetallesPlantas(),
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

//                iconTheme: IconThemeData(
//                  color: Colors.red, //change your color here
//                ),
                    automaticallyImplyLeading: false,
                    /* leading: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ), */

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


  //funcion para obtener datos de la base de datos
  getData(id){
    print('el id del reporte es '+ id);
    FirebaseFirestore.instance.collection('reportes').doc(id).get().then((DocumentSnapshot doc){
      setState(() {
        _image = doc.data()['foto'];
        _nombre= doc.data()['planta'];
        _fecha= doc.data()['fecha'];
        _direccion= doc.data()['direccion'];
        _latitud= doc.data()['latitud'];
        _longitud= doc.data()['longitud'];
        
        estado= true;

      });
      
    }).catchError((error){
      print('no pudimos recuperar nada');
    }); 


  }
}
