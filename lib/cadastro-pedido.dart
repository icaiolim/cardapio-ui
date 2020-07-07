import 'dart:async';

import 'package:cardapio/model/itemCardapio.dart';
import 'package:cardapio/model/mesaPedido.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/pedido.dart';

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  // Controles para os campos de texto
  TextEditingController txtPreco = TextEditingController();
  TextEditingController txtQuantidade = TextEditingController();
  TextEditingController txtTotal = TextEditingController();

  // Instancia do Firebase
  var db = Firestore.instance;
  //Stream para "ouvir" o Firebase
  StreamSubscription<QuerySnapshot> listen;

  String idMesa;
  String imagemCardapio = 'icon-food.png';
  Pedido pedido;
  MesaPedido mesaPedido;
  ItemCardapio itemCardapio = ItemCardapio('', 'Item', 0.0, '');
  List<ItemCardapio> cardapio = List();

  @override
  void initState() {
    super.initState();

    txtPreco.text = '0.00';
    txtQuantidade.text = '1';
    txtTotal.text = '0.00';

    // GET Cardapio
    //cancelar o listen, caso a coleção esteja vazia.
    listen?.cancel();

    //retornar dados da coleção e inserir na lista dinâmica
    listen = db.collection('cardapio').snapshots().listen((res) {
      setState(() {
        cardapio = res.documents
            .map((doc) => ItemCardapio.fromMap(doc.data, doc.documentID))
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
    //
    // Recuperar ID do documento
    //

    mesaPedido = ModalRoute.of(context).settings.arguments;

    idMesa = mesaPedido.mesa.id.toString();

    if (mesaPedido.pedido != null) {
      if (pedido == null) {
        getPedido(mesaPedido.pedido.id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cardapio'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Itens:',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 15.0,
                  child: Divider(
                    color: Colors.red,
                    height: .0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                //fonte de dados
                stream: db.collection('cardapio').snapshots(),

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
                                cardapio[index].nome,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                  'R\$ ' +
                                      cardapio[index].valor.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold)),
                              onTap: () {
                                setState(() {
                                  txtPreco.text =
                                      cardapio[index].valor.toString();

                                  imagemCardapio = cardapio[index].imagem;

                                  getValorTotal();

                                  itemCardapio.id = cardapio[index].id;
                                  itemCardapio.nome = cardapio[index].nome;
                                  itemCardapio.valor = cardapio[index].valor;
                                  itemCardapio.imagem = cardapio[index].imagem;
                                });
                              },
                            );
                          });
                  }
                }),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.red[400],
            height: 240.0,
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage:
                                AssetImage('assets/images/$imagemCardapio'),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            itemCardapio.nome,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Valor Unit',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            child: Text(
                              'R\$ ' + itemCardapio.valor.toStringAsFixed(2),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Ubuntu',
                                fontSize: 32.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            width: 100,
                            child: TextField(
                              onChanged: (value) => {
                                txtQuantidade.text = value,
                                if (pedido != null)
                                  pedido.quantidade = int.parse(value),
                                getValorTotal(),
                              },
                              controller: txtQuantidade,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelText: "Quantidade",
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Total: R\$ ' +
                            double.parse(txtTotal.text).toStringAsFixed(2),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 160,
                        child: RaisedButton(
                          color: Colors.red[900],
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onPressed: () {
                            getValorTotal();

                            if (pedido == null) {
                              pedido = Pedido(
                                '',
                                itemCardapio.id,
                                itemCardapio.nome,
                                int.parse(idMesa),
                                int.parse(txtQuantidade.text),
                                itemCardapio.valor,
                              );

                              inserir(pedido);
                            } else {
                              pedido.idCardapio = itemCardapio.id;
                              pedido.item = itemCardapio.nome;
                              pedido.mesa = int.parse(idMesa);
                              pedido.quantidade = int.parse(txtQuantidade.text);
                              pedido.valor = itemCardapio.valor;

                              atualizar(pedido);
                            }

                            Navigator.pop(context);
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                pedido == null ? Icons.add : Icons.update,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                pedido == null ? 'Adicionar' : 'Atualizar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Ubuntu',
                                    fontSize: 18),
                              ),
                            ],
                          ),
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
    );
  }

  void getPedido(String idDocumento) async {
    // Recuperar documento no Firestore
    DocumentSnapshot doc =
        await db.collection('pedidos').document(idDocumento).get();

    setState(() {
      pedido = Pedido.map(doc.data, doc.documentID);

      itemCardapio.nome = pedido.item;
      itemCardapio.valor = pedido.valor;

      txtPreco.text = pedido.valor.toString();
      txtQuantidade.text = pedido.quantidade.toString();
      txtTotal.text = (pedido.quantidade * pedido.valor).toString();

      getImagem(pedido.idCardapio);
    });
  }

  void getImagem(String idCardapio) async {
    DocumentSnapshot doc =
        await db.collection('cardapio').document(idCardapio).get();

    setState(() {
      itemCardapio = ItemCardapio.map(doc.data);
      imagemCardapio = itemCardapio.imagem;
    });
  }

  void getValorTotal() {
    double preco = double.tryParse(txtPreco.text);
    double quantidade = double.tryParse(txtQuantidade.text);

    double total = preco * quantidade;

    setState(() {
      txtTotal.text = total.toString();
    });
  }

  //
  // ATUALIZAR
  //

  void atualizar(Pedido pedido) async {
    await db.collection('pedidos').document(pedido.id).updateData({
      'idCardapio': pedido.idCardapio,
      'item': pedido.item,
      'mesa': pedido.mesa,
      'quantidade': pedido.quantidade,
      'valor': pedido.valor,
    });
  }

  //
  // INSERIR
  //

  void inserir(Pedido pedido) async {
    await db.collection('pedidos').add({
      'idCardapio': pedido.idCardapio,
      'item': pedido.item,
      'mesa': pedido.mesa,
      'valor': pedido.valor,
      'quantidade': pedido.quantidade,
    });
  }
}
