import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/pedido.dart';

class FoodTable extends StatefulWidget {
  @override
  _FoodTableState createState() => _FoodTableState();
}

class _FoodTableState extends State<FoodTable> {
  //Conexão Fluter+Firebase
  final db = Firestore.instance;
  final String colecao = "pedidos";

  //Lista dinâmica para manipulação dos dados
  List<Pedido> lista = List();

  //Stream para "ouvir" o Firebase
  StreamSubscription<QuerySnapshot> listen;

  @override
  void initState() {
    super.initState();

    //cancelar o listen, caso a coleção esteja vazia.
    listen?.cancel();

    //retornar dados da coleção e inserir na lista dinâmica
    listen = db.collection(colecao).snapshots().listen((res) {
      setState(() {
        lista = res.documents
            .map((doc) => Pedido.fromMap(doc.data, doc.documentID))
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
    final int idMesa = ModalRoute.of(context).settings.arguments;
    double total = 0;

    lista = lista.where((item) => item.mesa == idMesa).toList();

    lista.forEach((item) => total += item.quantidade * item.valor);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mesa ' + idMesa.toString()),
          centerTitle: true,
        ),

        //
        // APRESENTAÇÃO DOS DADOS
        //
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(18.0),
              color: Colors.red,
              child: Row(
                children: <Widget>[
                  Text(
                    'Total: ',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    'R\$' + total.toString(),
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  //fonte de dados
                  stream: db
                      .collection(colecao)
                      .where('mesa', isEqualTo: idMesa)
                      .snapshots(),

                  //exibição dos dados
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());

                      default:
                        //documentos retornados do Firebase
                        List<DocumentSnapshot> docs = snapshot.data.documents;
                        return ListView.builder(
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  lista[index].item,
                                  style: TextStyle(fontSize: 20),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    Text(
                                        'Valor Unit.: R\$ ' +
                                            lista[index].valor.toString(),
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(
                                      width: 22.0,
                                    ),
                                    Text(
                                        'Qtd.: ' +
                                            lista[index].quantidade.toString(),
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      // _deletar(context, docs[index], index);
                                    }),
                                onTap: () {
                                  Navigator.pushNamed(context, '/cadastro',
                                      arguments: lista[index].id);
                                },
                              );
                            });
                    }
                  }),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          elevation: 0,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/cadastro', arguments: null);
          },
        ),
      ),
    );
  }
}
