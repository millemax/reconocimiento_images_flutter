import 'package:flutter/material.dart';


class CardWidget extends StatelessWidget {

  final String _imageUrl;
  final String _texto;

  CardWidget(this._texto, this._imageUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _crearContenedor(),
      onTap: () {
        /* Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => DetailScreen(_texto, _imageUrl) )
        ); */
      },
    );
    
  }

  Widget _crearContenedor() {
    return Center(
      child: SizedBox(
        width: 175,
        height: 240,
        child: Container(
          margin: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromARGB(30, 0, 0, 0),
                offset: Offset(0.0, 5.0),
                spreadRadius: 0,
                blurRadius: 10
              )
            ]
          ),
          child: Card(
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                    _crearImagenFondo(),
                    Column(
                      children: <Widget>[
                        Container(margin: EdgeInsets.only(top: 10)),
                        _crearHeader(),
                        Expanded(child: Container()),
                        _mensaje()
                      ],
                    )
                ],
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
            ),
        ),
        
      ),  
    );
  }

  Widget _crearHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Column(
              children: <Widget>[
                Text('Plantas', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                Text('medicinales', style: TextStyle(color: Colors.white)),
              
              ],
            ),
        ),
        /* Container(
          child: Icon(Icons.favorite, color: Colors.white, size: 50),
          margin: EdgeInsets.only(right: 5),
        ) */
      ],
    );
       
  }

  Widget _crearImagenFondo() {
    return Hero(
      child: Image(
        image: NetworkImage(_imageUrl),
        fit: BoxFit.cover,
      ),
      tag: _texto,
    );
    
  }

  Widget _mensaje() {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(bottom: 20, left: 20),
        child: Text( _texto,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30
          ),
        ),
      );
  }

}