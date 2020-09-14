import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  String _email;
  String _nombres;
  String _password;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    //----declaramos el color del tema---
    Color primary = Theme.of(context).primaryColor;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
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
                  Colors.white,
                  primary,
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
                //----------boton de registro inicio---
                child: OutlineButton(
                  highlightedBorderColor: Colors.white,
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                  highlightElevation: 0.0,
                  splashColor: Colors.white,
                  highlightColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
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
            //---------imagen con curva de inicio--
            Expanded(
              child: Align(
                child: ClipPath(
                  child: Container(
                    color: Colors.white,
                    height: 300,
                  ),
                  clipper: BottomWaveClipper(),
                ),
                alignment: Alignment.bottomCenter,
              ),
            )
            //----
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
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
                        shape: BoxShape.circle, color: Colors.white),
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
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              ),
            ),
            //----------circulo pequeño----
            Positioned(
              width: MediaQuery.of(context).size.width * 0.08,
              height: MediaQuery.of(context).size.width * 0.08,
              bottom: 0,
              right: MediaQuery.of(context).size.width * 0.38,
              child: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

//-------widgett boton de login------
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
        borderRadius: BorderRadius.circular(30.0),
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

  //-------widgett boton de login------
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
        borderRadius: BorderRadius.circular(30.0),
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
          FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).then((value){
              Navigator.pushReplacementNamed(context, 'menu');
         
          });
          
        }
      },
    );
  }

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
        borderRadius: BorderRadius.circular(30.0),
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
          FirebaseAuth.instance.createUserWithEmailAndPassword(email:_email, password:_password).then((value){
                  final String id = FirebaseAuth.instance.currentUser.uid;
                  FirebaseFirestore.instance.collection('users').doc(id).set({
                    'correo':_email,
                    'nombre':_nombres,
                    
                  }).then((value){
                     Navigator.pushReplacementNamed(context, 'menu');
                     /* showDialog(
                       context: context,
                       barrierDismissible: false,
                       builder: (BuildContext context){
                         AlertDialog(
                            title:Text('Ya estas Registrado!'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text('ya eres parte de medic plant'),
                                  Text('gracias por registrarte'),
                                ],
                              ) ,
                              ),
                            actions: [
                              FlatButton(
                                onPressed: (){
                                    Navigator.pushReplacementNamed(context, 'menu');
                                },
                                child: Text('ok'))
                            ],

                       );

                       }
                       
                     );
                  */

                  })
                  .catchError((error){
                    //error al cargar los datos a firestore
                    

                    

                  });



                      

          })
          .catchError((error){

            //error en crear usuario

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
                                            fontSize: 40,
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
                                      obsecure: false,
                                      validator: emailValidator,
                                      hint: "Correo",
                                      label: "Correo",
                                    )),
                                //-------------------campo contraseña login
                                Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: CustomTextField(
                                      onchanged: (valor) {
                                        _password = valor;
                                      },
                                      icon: Icon(Icons.lock),
                                      obsecure: true,
                                      validator: passwordValidator,
                                      hint: "Contraseña",
                                      label: "Contraseña",
                                    )),
                              ],
                            )),

                        //----------------boton registro en vista login---
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            child: _buttonEnvio("Iniciar", Colors.white,
                                Colors.red, Colors.purple[300], Colors.white),
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
                                      EdgeInsets.only(bottom: 25, right: 40),
                                  child: Text(
                                    "Regi",
                                    style: TextStyle(
                                        fontSize: 44,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Align(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 130,
                                    padding: EdgeInsets.only(top: 40, left: 28),
                                    child: Text(
                                      "stro",
                                      style: TextStyle(
                                          fontSize: 44,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
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
                                      obsecure: false,
                                      validator: emailValidator,
                                      hint: "Correo",
                                      label: "Correo",
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: CustomTextField(
                                      onchanged: (valor) {
                                        _password = valor;
                                      },
                                      icon: Icon(Icons.lock),
                                      obsecure: true,
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
                            Colors.purple[300],
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
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//........clase customtextfiel

class CustomTextField extends StatelessWidget {
  final FormFieldSetter<String> onchanged;
  final Icon icon;
  final String hint;
  final String label;
  final bool obsecure;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;

  CustomTextField(
      {this.onchanged,
      this.label,
      this.icon,
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
          fontSize: 20,
        ),
        decoration: InputDecoration(
            labelStyle: TextStyle(
              fontSize: 25,
            ),
            hintStyle: TextStyle(fontSize: 20),
            labelText: label,
            hintText: hint,
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
                data: IconThemeData(color: Theme.of(context).primaryColor),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 30, right: 10),
            )),
      ),
    );
  }
}
