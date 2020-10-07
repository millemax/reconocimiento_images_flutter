import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class MyHome extends StatefulWidget {
  MyHome({Key key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  //-----estado en false
  //----------------resupera toda la lista de reportes------------
  var recuperado = [];

  bool estado = false;
  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        body: estado == false
            ? Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: Myclipper(),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          /* color: Colors.red, */
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: Swiper(
                            itemCount: recuperado.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image(
                                      image: NetworkImage(
                                        recuperado[index]['data']['image'],
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      decoration: BoxDecoration(
                                        color: Colors.purple[300],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            recuperado[index]['data']
                                                ['nombrecomun'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                            loop: true,
                            viewportFraction: 0.8,
                            scale: 0.9,
                            onTap: (value) {
                              print('es el value : ' + value.toString());
                              print(recuperado[value]['id']);
                              Navigator.pushNamed(
                                context,
                                'DescripcionPlanta',
                                arguments: recuperado[value]['id'],
                              );
                            },
                            /*  pagination: SwiperPagination(), */
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    /* color: Colors.amber, */
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/cuadrado.png"),
                        colorFilter: new ColorFilter.mode(
                            Colors.white, BlendMode.dstATop),
                        fit: BoxFit.contain,
                        scale: 5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/images/camara.png",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06),
                                    SizedBox(width: 10),
                                    Text("CAPTURA LA FOTO",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/chip.png",
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                    ),
                                    SizedBox(width: 10),
                                    Text("ANALIZA",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/save.png",
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                    ),
                                    SizedBox(width: 10),
                                    Text("GUARDA LA FOTO",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ]),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/PUNTA.png"),
                              colorFilter: new ColorFilter.mode(
                                  Colors.white, BlendMode.dstATop),
                              fit: BoxFit.cover,
                            ),
                          ),
                          /* color: Colors.blue, */
                          height: double.infinity,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Image.asset(
                              "assets/images/ma.png",
                            ),
                          ),
                        ),
                        //bacground
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  //--------------------consulta para obtener todas las plantas y su informacion
  getData() async {
    FirebaseFirestore.instance.collection('plantas').get().then((value) {
      setState(() {
        estado = true;
      });

      if (value != null) {
        recuperado.clear();

        value.docs.forEach((element) {
          recuperado.add({'data': element.data(), 'id': element.id});
        });
      }
    });
  }
}

//---dibuja elcontainer debajo de las fotos de las plantas

class Myclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 70);

    var controllPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return null;
  }
}

//----
