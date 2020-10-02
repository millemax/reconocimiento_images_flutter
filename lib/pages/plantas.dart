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
  //----------------resupera toda la lista------------
  /* List<User> users = List();
  //-----filtarr----
  List<User> filteredUsers = List(); */

  @override
  /* void initState() {
    super.initState();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        //-------filtrar---
        filteredUsers = users;
      });
    });
  } */

  //---------------------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Column(
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
                        padding: EdgeInsets.only(top: 20, left: 8, right: 8),
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
                                    color: Theme.of(context).primaryColor),
                                child: Icon(Icons.search),
                              ),
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                          ),
                          onChanged: (string) {
                            /* setState(() {
                              filteredUsers = users 
                                  .where((u) => (u.name
                                          .toLowerCase()
                                          .contains(string.toLowerCase()) ||
                                      u.email
                                          .toLowerCase()
                                          .contains(string.toLowerCase())))
                                  .toList();
                            }); */
                          },
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
                  padding: EdgeInsets.all(10.0),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
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
                                child: Image.asset(
                                  "assets/images/FLOR.jpg",
                                  scale: 62,
                                  /* fit: BoxFit.fill, */
                                ),
                              ),
                            ),

                            //-------------------------aqui..dejo la marca
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //------------
                                Text(
                                  "hola",
                                  /* filteredUsers[index].name, */
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                //-------------------
                                Text(
                                  "hola",
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
}
