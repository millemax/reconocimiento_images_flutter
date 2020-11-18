import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'olvidoContraseña.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //-------variable para detectar el cambio de scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //-----declaramos los campos de login email y password-
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  //-----visualizar constraseña-------------------------------------
  bool _obscureText = true;
  //-----------fin visualizar contrasena----------------------------
  String _email;
  String _nombres;
  String _password;
  bool _autoValidate = false;

  //----------------metodo par ir ala pagina recuperar conrsña---
  void pushRoute(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) => OlvidoContrasena()),
    );
  }

  @override
  Widget build(BuildContext context) {
    //----declaramos el color del tema---
    Color primary = Theme.of(context).primaryColor;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            //------------------
            //---------imagen con curva de inicio--
            Expanded(
              child: Align(
                child: ClipPath(
                  child: Container(
                    color: Colors.white12,
                    height: MediaQuery.of(context).size.height,
                  ),
                  clipper: BottomWaveClipper(),
                ),
                alignment: Alignment.bottomCenter,
              ),
            ),
            //----
            //------------------
            Column(
              children: [
                logo(context),
                //------------------ boton login inicio---
                Padding(
                  padding: EdgeInsets.only(
                    top: 80,
                    left: 20,
                    right: 20,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 50,
                    //------le pasa como un parametro el formulario
                    child: _button(
                      "Iniciar Sesión",
                      primary,
                      Colors.white,
                      Theme.of(context).primaryColor,
                      Colors.white,
                      _loginSheet,
                    ),
                  ),
                ),
                //---------------------------
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 50,

                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.9),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    //----------boton de registro inicio---
                    child: OutlineButton(
                      highlightedBorderColor: Colors.white,
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      highlightElevation: 0.0,
                      splashColor: Colors.white,
                      highlightColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        "Registro",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      //-------funcion para llamar al formulario de registro--
                      onPressed: () {
                        _registerSheet();
                      },
                    ),
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }

  //-----------widget logo----------------
  Widget logo(BuildContext context) {
    //---------toma todo el tamaño del cuerpo--
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.15),
      child: Container(
        height: 220,
        width: double.infinity,
        child: Stack(
          children: [
            //------------circulo grande
            Positioned(
              child: Container(
                height: 154,
                child: Align(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withRed(200)),
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
            ),
            //----logo dentro del circulo grande-----
            Positioned(
              child: Container(
                height: 154,
                child: Align(
                  child: Image.asset("assets/images/logoo.png", height: 120),
                ),
              ),
            ),
            //------circulo mediano----
            Positioned(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.15,
              bottom: MediaQuery.of(context).size.width * 0.046,
              right: MediaQuery.of(context).size.width * 0.22,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.8)),
              ),
            ),
            //----------circulo pequeño----
            Positioned(
              width: MediaQuery.of(context).size.width * 0.08,
              height: MediaQuery.of(context).size.width * 0.08,
              bottom: 0,
              right: MediaQuery.of(context).size.width * 0.38,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.7)),
              ),
            ),
          ],
        ),
      ),
    );
  }

//-------widgett boton iniciar sesion ------
  Widget _button(String text, Color splashColor, Color highlightColor,
      Color fillColor, Color textColor, void function()) {
    return RaisedButton(
      highlightElevation: 0.0,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: 0.0,
      color: fillColor,
      //-----bordear
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.white, width: 1.0),
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
        ),
      ),
      onPressed: () {
        function();
      },
    );
  }

  //-------widgett "Iniciar"  ------ logearse
  Widget _buttonEnvio(String text, Color splashColor, Color highlightColor,
      Color fillColor, Color textColor) {
    return RaisedButton(
      highlightElevation: 0.0,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: 0.0,
      color: fillColor,
      //-----bordear
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
        ),
      ),
      onPressed: () {
        if (_formKey1.currentState.validate()) {
          FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password)
              .then((value) {
            Navigator.pushReplacementNamed(context, 'menu');
          }).catchError((onError) {
            print("==================================================");
            print("no pudmismos autentificare");
            _showMaterialDialog();
          });
        }
      },
    );
  }

//show alert dialog para las notificaciones
  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new Image.asset(
                    "assets/images/cancel.png",
                    scale: 5,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  new Text(
                      "No pudimos autentificarte, intentalo de nuevo o revisa tu conexion!!!",
                      textAlign: TextAlign.center),
                ],
              ),
              actions: <Widget>[
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Theme.of(context).primaryColor),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 119, vertical: 10),
                        child: Text("OK"),
                      )),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  //-----------------boton para registraerse-----
  Widget _buttonEnvioRegistro(String text, Color splashColor,
      Color highlightColor, Color fillColor, Color textColor) {
    return RaisedButton(
      highlightElevation: 0.0,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: 0.0,
      color: fillColor,
      //-----bordear
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
        ),
      ),
      onPressed: () {
        if (_formKey2.currentState.validate()) {
          print(_nombres);
          FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password)
              .then((value) {
            final String id = FirebaseAuth.instance.currentUser.uid;
            FirebaseFirestore.instance.collection('users').doc(id).set({
              'correo': _email,
              'nombre': _nombres,
            }).then((value) {
              //----------------------MENSAJE DE BIENVENIDA NUEVOS USUARIOS NUEVOS-----
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new Image.asset(
                        "assets/images/check.png",
                        scale: 2.5,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      new Text("Bienvenido a MEDICPLANT!!!",
                          textAlign: TextAlign.center),
                    ],
                  ),
                  actions: <Widget>[
                    GestureDetector(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).primaryColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 119, vertical: 10),
                            child: Text("OK"),
                          )),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                    )
                  ],
                ),
              );
            }).catchError((error) {
              //error al cargar los datos a firestore
            });
          }).catchError((error) {
            //error en crear usuario
            //----------------------MENSAJE ERROR AL CREAR UN USUARIO -----
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new Image.asset(
                      "assets/images/cancel.png",
                      scale: 5,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    new Text(
                        "No pudimos registrarte, intentalo de nuevo o revisa tu conexion!!!",
                        textAlign: TextAlign.center),
                  ],
                ),
                actions: <Widget>[
                  GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 119, vertical: 10),
                          child: Text("OK"),
                        )),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          });
        }
      },
    );
  }

//----------funcion ---logearse
  void _loginSheet() {
    _scaffoldKey.currentState.showBottomSheet(
      (BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Theme.of(context).canvasColor),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
            //-----------contenedor campo vista login----
            child: Container(
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: ListView(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Stack(
                      //----------hijos----
                      children: [
                        Positioned(
                          left: 10,
                          top: 10,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30.0,
                              color: Theme.of(context).primaryColor,
                            ),
                            //--------------estas variables declaradas en la parte superior------
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  //---------otro hijo--
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                          child: Stack(
                            //---------circulo y letra login adentro----
                            children: [
                              //-------------circulo login-----
                              Positioned(
                                child: Align(
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              //-----------letra login--
                              Positioned(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 35),
                                        child: Text(
                                          "Iniciar",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Text(
                                        "Sesión",
                                        style: TextStyle(
                                            fontSize: 34.5,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //--------------campo nombre login----

                        Form(
                            key: _formKey1,
                            autovalidate: _autoValidate,
                            child: Column(
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 20, top: 60),
                                    child: CustomTextField(
                                      onchanged: (valor) {
                                        _email = valor;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      icon: Icon(Icons.email),
                                      suffix: IconButton(
                                          icon: Icon(null), onPressed: () {}),
                                      obsecure: false,
                                      validator: emailValidator,
                                      hint: "Correo",
                                      label: "Correo",
                                    )),
                                //-------------------campo contraseña login
                                Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: CustomTextField(
                                      icon: Icon(Icons.lock),
                                      suffix: IconButton(
                                          icon: Icon(_obscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          }),
                                      onchanged: (valor) {
                                        _password = valor;
                                      },
                                      obsecure: _obscureText,
                                      validator: passwordValidator,
                                      hint: "Contraseña",
                                      label: "Contraseña",
                                    )),
                              ],
                            )),

                        //------------olvido su contraseña-----

                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.only(right: 26, bottom: 15),
                              child: Text(
                                "¿Olvido su contraseña?",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            onTap: () => pushRoute(context),
                          ),
                        ),

                        //----------------boton registro en vista login---
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            child: _buttonEnvio(
                                "Iniciar",
                                Colors.white,
                                Colors.red,
                                Theme.of(context).primaryColor,
                                Colors.white),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.45,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //validar usario correo

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Requerido';
    if (!regex.hasMatch(value))
      return '*Ingresa un correo valido';
    else
      return null;
  }
  //validar cntraseña

  String passwordValidator(String value) {
    if (value.isEmpty) return '*Requerido';
    if (value.length <= 6)
      return 'Más de 6 caracteres porfavor';
    else
      return null;
  }

  // validar nombre
  String nombreValidator(String value) {
    Pattern patronNombre =
        r'^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.-]+$';
    RegExp regExpName = new RegExp(patronNombre);
    if (value.isEmpty) return '*Requerido';
    if (!regExpName.hasMatch(value))
      return 'Nombre no es correcto';
    else
      return null;
  }

//-------funcion registro ---
  void _registerSheet() {
    _scaffoldKey.currentState.showBottomSheet(
      (BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Theme.of(context).canvasColor),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40),
            ),
            //---------------contenedor de campos vista registro---
            child: Container(
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: ListView(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          top: 10,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  //------------------------scroll de la interfaz de registro--
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                          child: Stack(
                            children: [
                              Positioned(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              //--------------------------letras "registro" dentro del circulo--
                              Positioned(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.only(bottom: 25, right: 28),
                                  child: Text(
                                    "Regi",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Positioned(
                                  child: Align(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 130,
                                      padding:
                                          EdgeInsets.only(top: 40, left: 20),
                                      child: Text(
                                        "stro",
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //..................campo nombre------

                        Form(
                            key: _formKey2,
                            autovalidate: _autoValidate,
                            child: Column(
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 20, top: 60),
                                    child: CustomTextField(
                                      onchanged: (valor) {
                                        _nombres = valor;
                                      },
                                      icon: Icon(Icons.account_circle),
                                      suffix: IconButton(
                                          icon: Icon(null), onPressed: () {}),
                                      obsecure: false,
                                      validator: nombreValidator,
                                      hint: "Nombres",
                                      label: "Nombres",
                                    )),
                                //-------------------campo contraseña login
                                Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: CustomTextField(
                                      onchanged: (valor) {
                                        _email = valor;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      icon: Icon(Icons.email),
                                      suffix: IconButton(
                                          icon: Icon(null), onPressed: () {}),
                                      obsecure: false,
                                      validator: emailValidator,
                                      hint: "Correo",
                                      label: "Correo",
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: CustomTextField(
                                      icon: Icon(Icons.lock),
                                      suffix: IconButton(
                                          icon: Icon(_obscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          }),
                                      onchanged: (valor) {
                                        _password = valor;
                                      },
                                      obsecure: _obscureText,
                                      validator: passwordValidator,
                                      hint: "Contraseña",
                                      label: "Contraseña",
                                    )),
                              ],
                            )),

                        //-----------------boton registro---
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: _buttonEnvioRegistro(
                            "Registrarme",
                            Colors.white,
                            Colors.red,
                            Theme.of(context).primaryColor,
                            Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//----clase de Bottom wave clipper la image curva del inicio -------
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, size.height);

    path.lineTo(size.width * 0.05, size.height);
    path.lineTo(size.width * 0.13, size.height * 0.93);

    path.quadraticBezierTo(size.width * 0.2, size.height - 80,
        size.width * 0.25, size.height - 65);
    path.quadraticBezierTo(size.width - (size.width * 0.25), size.height,
        size.width * 0.96, size.height * 0.6);

    path.quadraticBezierTo(
        size.width, size.height * 0.5, size.width, size.height * 0.3);

    path.quadraticBezierTo(size.width * 0.99, size.height * 0.1,
        size.width * 0.90, size.height * 0.07);
    //---SEGUNDA MITAD HOJA
    path.quadraticBezierTo(size.width * 0.90, size.height * 0.1,
        size.width * 0.80, size.height * 0.15);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.2,
        size.width * 0.6, size.height * 0.19);
    //...POR EL,LOGO
    path.quadraticBezierTo(size.width * 0.18, size.height * 0.23,
        size.width * 0.022, size.height * 0.5);
    //---in sES
    path.quadraticBezierTo(size.width - (size.width * 1.03), size.height * 0.6,
        size.width * 0.09, size.height * 0.75);

    path.quadraticBezierTo(size.width - (size.width * 0.85), size.height * 0.8,
        size.width * 0.15, size.height * 0.85);

//----ADENTRO HOJ
    path.quadraticBezierTo(size.width - (size.width * 0.7), size.height * 0.8,
        size.width * 0.38, size.height * 0.6);
    path.quadraticBezierTo(size.width - (size.width * 0.6), size.height * 0.5,
        size.width * 0.53, size.height * 0.45);
    //--RAMI GORDO
    path.quadraticBezierTo(size.width - (size.width * 0.6), size.height * 0.5,
        size.width * 0.4, size.height * 0.7);
    path.quadraticBezierTo(size.width - (size.width * 0.4), size.height * 0.72,
        size.width * 0.36, size.height * 0.75);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//........clase customtextfiel

class CustomTextField extends StatelessWidget {
  final FormFieldSetter<String> onchanged;
  final Icon icon;
  final IconButton suffix;
  final String hint;
  final String label;
  final bool obsecure;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;

  CustomTextField(
      {this.onchanged,
      this.label,
      this.icon,
      this.suffix,
      this.hint,
      this.obsecure = false,
      this.validator,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        onChanged: onchanged,
        keyboardType: keyboardType,
        validator: validator,
        obscureText: obsecure,
        style: TextStyle(
          fontSize: 17,
        ),
        decoration: InputDecoration(
            labelStyle: TextStyle(
              fontSize: 17,
            ),
            hintStyle: TextStyle(fontSize: 13),
            labelText: label,
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                        width: 1.0, color: Theme.of(context).primaryColor),
                  ),
                ),
                child: IconTheme(
                  data: IconThemeData(color: Theme.of(context).primaryColor),
                  child: icon,
                ),
              ),
            ),
            suffixIcon: IconTheme(
                data: IconThemeData(color: Theme.of(context).primaryColor),
                child: suffix)),
      ),
    );
  }

//show alert dialog para las notificaciones

}
