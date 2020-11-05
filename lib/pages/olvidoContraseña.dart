import 'package:MedicPlant/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//---toast notificacion--
import 'package:fluttertoast/fluttertoast.dart';

class OlvidoContrasena extends StatefulWidget {
  @override
  _OlvidoContrasenaState createState() => _OlvidoContrasenaState();
}

class _OlvidoContrasenaState extends State<OlvidoContrasena> {
  //-------recuperacion de contraseña--
  TextEditingController correoCtrl = TextEditingController();
  //creamos la llave para el control de formulario
  final _formKey = GlobalKey<FormState>();

  //------------validar usario correo

  String correoValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Requerido';
    if (!regex.hasMatch(value))
      return '*Ingrese un correo válido';
    else
      return null;
  }

  bool _autovalidate = false;

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
            Form(
              key: _formKey,
              autovalidate: _autovalidate,
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 50, top: 100),
                          child: Text(
                            "Bienvenido",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: Text(
                            "De Nuevo !!!",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        )
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "assets/images/img.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      //------------------regresar a login--------
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                        child: GestureDetector(
                          child: Image.asset(
                            "assets/images/cartel.png",
                            width: MediaQuery.of(context).size.width * 0.35,
                          ),
                          onTap: () => pushRoute(context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22.0, left: 30.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              "Volver atras",
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.016,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                      //-----------------fin regresar a login---------
                    ],
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
                                "Ingrese su correo par poder restablecer su contraseña",
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
                                controller: correoCtrl,
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
                                validator: correoValidator,
                              ),
                            ],
                          ),
                        ),
                        //--------boton enviar
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 5, left: 15, right: 15, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  restablecerContrasena(context);
                                },
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 140),
                                color: Theme.of(context).primaryColorDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
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
            ),
          ],
        ),
      ),
    );
  }

  //------funcion para restablecer contraseña--

  void restablecerContrasena(BuildContext context) async {
    if (_formKey.currentState.validate()) {}
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: correoCtrl.text)
        .then(
      (value) {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg:
              "El enlace de restablecimiento de contraseña ha enviado su correo,"
              "utilícelo para cambiar la contraseña",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
        );
      },
    ).catchError((error) {
      Fluttertoast.showToast(
        msg: "Correo inválido",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
    });
  }
}
