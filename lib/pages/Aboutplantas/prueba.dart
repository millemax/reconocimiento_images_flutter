import 'package:MedicPlant/pages/Aboutplantas/detallesPlantas_page.dart';
import 'package:flutter/material.dart';
import 'package:MedicPlant/pages/Aboutplantas/informacionPlanta_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // this sliver app bar is only use to hide/show the tabBar, the AppBar
    // is invisible at all times. The to the user visible AppBar is below
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                                height: 280.0,
                                width: double.infinity,
                                child: Image.asset(
                                  "assets/images/rosa.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              //----------contenedor redondeado y texto
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 250, bottom: 10),
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
                                        'Business Office',
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
                                          '2020/09/2020 13:45 p.m',
                                          style: TextStyle(fontSize: 14.0),
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
                                          color: Theme.of(context).primaryColor,
                                          size: 19.0,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Andahuaylas, Pacucha-Pacucha',
                                          style: TextStyle(fontSize: 14.0),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text("Ver planta en mapa"),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 1.0),
                                        child: Image.asset(
                                          "assets/images/mapalocation.png",
                                          scale: 7,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                          //-----------widget texto / icon  ver en mapa
                        ],
                      ),
                    ),
                    expandedHeight: 450.0,
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
            /*Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                child: SafeArea(
                  top: false,
                  child: AppBar(
                    backgroundColor: Colors.transparent,

//                iconTheme: IconThemeData(
//                  color: Colors.red, //change your color here
//                ),
                    automaticallyImplyLeading: true,
                    elevation: 0,
                    title: Text(
                      "My Title",
                    ),

                    centerTitle: true,
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
