import 'package:cardapio/model/mesa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodTable extends StatefulWidget {
  @override
  _FoodTableState createState() => _FoodTableState();
}

class _FoodTableState extends State<FoodTable> {
  
  Mesa mesa;

  @override
  Widget build(BuildContext context) {
    
    getMesa();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            mesa.nome,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 35.0,
                  ),
                  Text(
                    mesa.nome,
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                ],
              ),
              ListTile(
                title: Text('test'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getMesa() async {
    final db = Firestore.instance;
    final doc = await db.collection('mesas').document('1').get();
    
    setState(() {
      mesa = Mesa.map(doc.data);
    });
  }
}
