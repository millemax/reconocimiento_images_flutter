import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 35,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(
                          'https://assets.puzzlefactory.pl/puzzle/166/238/original.jpg'))),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black),
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

          // 'https://assets.puzzlefactory.pl/puzzle/166/238/original.jpg'
        ],
      ),
    );
  }
}
