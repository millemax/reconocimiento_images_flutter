import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [logo(context), Text("HOLA")],
        ),
      ),
    );
  }

  Widget logo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.15),
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Stack(
          children: [
            Positioned(
                child: Container(
              height: 154,
              color: Colors.amber,
              child: Align(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  width: 150,
                  height: 150,
                ),
              ),
            )),
            Positioned(
                child: Container(
              height: 154,
              child: Align(
                child: Text(
                  "Medic plant",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Required';
    if (!regex.hasMatch(value))
      return '*Ingresa un correo valido';
    else
      return null;
  }

  String passwordValidator(String value) {
    if (value.isEmpty) return '*Requerido';
    if (value.length <= 6)
      return 'Más de 6 caracteres porfavor';
    else
      return null;
  }
}
