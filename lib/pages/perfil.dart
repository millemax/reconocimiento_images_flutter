import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';

class Perfil extends StatefulWidget {
  Perfil({Key key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  TextEditingController controller = TextEditingController();
  bool user = true;
  //variables para la camara
  File _image;
  String _correo;
  bool estado = false;

  final picker = ImagePicker();

//funcion para obtener las imagenes de la camara
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String id = FirebaseAuth.instance.currentUser.uid;
    getCorreo(id);
    return SafeArea(
      child: Scaffold(
          floatingActionButton: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 30),
                  child: FloatingActionButton(
                    backgroundColor: Colors.purple[300],
                    focusColor: Colors.amber,
                    onPressed: () {
                      if ((controller.text.isNotEmpty &&
                              controller.text.length >= 6) ||
                          _image != null) {
                        uploadImage();
                        _changePassword(controller.text);
                        showDialogChnage();
                        controller.clear();
                      } else {
                        print('campo vacio');
                      }
                    },
                    child: Icon(Icons.save),
                  )),
            ],
          ),
          body: estado == false
              ? Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                      ),
                      Stack(
                        children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(id)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                DocumentSnapshot data = snapshot.data;

                                if (!snapshot.hasData) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.93,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  return Container(
                                      height: 150,
                                      width: 150,
                                      decoration: data.data()['fotoperfil'] ==
                                              null
                                          ? BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: _image == null
                                                  ? DecorationImage(
                                                      scale: 5,
                                                      image: AssetImage(
                                                          'assets/images/user.png'))
                                                  : DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(_image)))
                                          : BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: _image == null
                                                  ? DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(data
                                                          .data()['fotoperfil']))
                                                  : DecorationImage(fit: BoxFit.cover, image: FileImage(_image))));
                                }
                              }),
                          FloatingActionButton(
                            backgroundColor: Colors.purple[200],
                            onPressed: () {
                              getImage();
                            },
                            child: Icon(Icons.edit),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Perfil',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Icon(Icons.email)),
                          title:
                              Title(color: Colors.black, child: Text(_correo)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: double.infinity,
                      ),
                      Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ExpansionTile(
                            title: ListTile(
                              leading: Icon(Icons.lock),
                              title: Title(
                                  color: Colors.black,
                                  child: Text('Contraseña')),
                              trailing: Icon(Icons.edit),
                            ),
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                child: TextFormField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    hintText: 'Contraseña mayor a 6 carácteres',
                                    labelStyle: TextStyle(
                                      fontSize: 25,
                                    ),
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
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          )),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut().then((value) {
                            SystemNavigator.pop();
                          }).catchError((value) {
                            print('error en cerrar sesion');
                          });
                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            leading: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Icon(Icons.exit_to_app),
                            ),
                            title: Title(
                                color: Colors.black,
                                child: Text('Cerrar Sesión')),
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                )),
    );
  }

  //funcion para cargar la imagen a firestore y recuerar la url
  uploadImage() async {
    final StorageReference postImgRef =
        FirebaseStorage.instance.ref().child('icons');
    var timeKey = DateTime.now();

    //carguemos a storage
    final StorageUploadTask uploadTask =
        postImgRef.child(timeKey.toString() + ".png").putFile(_image);

    // recuperamos la  url esperamos que termine de cargar
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    final String url = imageUrl.toString();

    saveDatabase(url);
  }

  saveDatabase(String url) {
    //guardar en la bd(nombre, precio, descripcion, duracion de cita, cupo, urlicono)
    final String id = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('users').doc(id).update({
      'fotoperfil': url,
    }).then((value) {});
  }

  _changePassword(String password) async {
    //Create an instance of the current user.
    await FirebaseAuth.instance.currentUser
        .updatePassword(password)
        .then((value) {
      print('contraseña');
    }).then((value) {});
  }

  getCorreo(id) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot doc) {
      setState(() {
        _correo = doc.data()['correo'];
        estado = true;
      });
    }).catchError((error) {
      print('no pudimos recuperar nada');
    });
  }

  showDialogChnage() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(top: 10.0),
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Datos Actualizados',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    height: 4.0,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, left: 15, top: 10),
                    child: Text(
                      'Los datos fueron actualizados satisfactoriamente',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      )))
            ],
          );
        });
  }
}
