import 'package:flutter/material.dart';

class InformacionPlantas extends StatefulWidget {
  InformacionPlantas({Key key}) : super(key: key);

  @override
  _InformacionPlantasState createState() => _InformacionPlantasState();
}

class _InformacionPlantasState extends State<InformacionPlantas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: ListView(
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
                        "Descripción breve",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        decoration: BoxDecoration(),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit\n"
                          "sed do eiusmod tempor incididunt ut labore et dolore magna"
                          " aliqua. \nUt enim ad minim veniam, quis nostrud exercitation"
                          " ullamco laboris nisi ut aliquip ex ea commodo consequat."
                          "Duis aute irure dolor in "
                          "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                          "sint occaecat cupidatat non proident,"
                          " sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          style: TextStyle(fontSize: 17, wordSpacing: 2),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
