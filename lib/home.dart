import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'model/mesa.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final db = Firestore.instance;
  StreamSubscription<QuerySnapshot> listen;
  List<Mesa> mesas = List();

  @override
  void initState() {
    super.initState();

    //cancelar o listen, caso a coleção esteja vazia.
    listen?.cancel();

    //retornar dados da coleção e inserir na lista dinâmica
    listen = db.collection('mesas').snapshots().listen((res) {
      setState(() {
        mesas = res.documents
            .map((doc) => Mesa.fromMap(doc.data, int.parse(doc.documentID)))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    listen?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text('icaiolim@gmail.com'),
                accountName: Text('Caio Lima'),
                currentAccountPicture: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/foto.jpg'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Inicio'),
                onTap: () => Navigator.pushNamed(context, '/home'),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Sobre'),
                onTap: () => Navigator.pushNamed(context, '/about'),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sair'),
                onTap: () => Navigator.pushNamed(context, '/login'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            'Cardapio App',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.red,
                height: 180.0,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset('assets/images/prate-salads.png'),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Cardapio App',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            fontSize: 36.0,
                          ),
                        ),
                        Text(
                          'Gestão de pedidos eficiente',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 17.0),
                color: Colors.red[300],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Mesas',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'Mova para os lados e visualize todas as mesas',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 120.0,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.red[300],
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: mesas.length,
                          itemBuilder: (context, index) {
                            //return Text(mesas[index].nome);
                            return Container(
                              padding: EdgeInsets.all(8.0),
                              child: RaisedButton(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 18.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  '/table',
                                  arguments: mesas[index].id,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.restaurant),
                                    Text(
                                      mesas[index].nome,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Pedidos',
                      style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 120,
                          child: RaisedButton(
                            color: Colors.white,
                            padding: EdgeInsets.all(18.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '0',
                                  style: TextStyle(
                                    color: Colors.yellowAccent[700],
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 42.0,
                                  ),
                                ),
                                Text(
                                  'Em Espera',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 120.0,
                          child: RaisedButton(
                            color: Colors.white,
                            padding: EdgeInsets.all(18.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '0',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 42.0,
                                  ),
                                ),
                                Text(
                                  'Servidos',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 120,
                          child: RaisedButton(
                            color: Colors.white,
                            padding: EdgeInsets.all(18.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '0',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 42.0,
                                  ),
                                ),
                                Text(
                                  'Atendidos',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
