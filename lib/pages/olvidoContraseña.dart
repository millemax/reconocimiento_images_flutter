import 'package:MedicPlant/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OlvidoContrasena extends StatefulWidget {
  @override
  _OlvidoContrasenaState createState() => _OlvidoContrasenaState();
}

class _OlvidoContrasenaState extends State<OlvidoContrasena> {
  //-------popo para regresar a login---
  void pushRoute(BuildContext context) {
    Navigator.pop(
      context,
      CupertinoPageRoute(builder: (BuildContext context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 50, top: 50),
                        child: Text(
                          "Bienvenido",
                          style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[300]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Text(
                          "De Nuevo !!!",
                          style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[300]),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/img.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5, left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Restablecer Contraseña",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ),
                      //--------parrfo-----
                      Padding(
                        padding: EdgeInsets.only(bottom: 5, left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Ingrese su contraseña par poder restablecer su contraseña",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //--------campor correo-------
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: 5, left: 15, right: 15),
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Correo",
                                hintText: "Correo",
                                //----llama los iconos declarados
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.mail_outline,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //--------boton enviar y return a login-----
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 5, left: 15, right: 15, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.arrow_left),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                child: Text(
                                  "Regresar a login",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                onTap: () => pushRoute(context),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {},
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 35),
                              color: Colors.purple[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: Text(
                                "Enviar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
