import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/usuario.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final db = Firestore.instance;
  TextEditingController txtUsuario = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Criar Usuário'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 15.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 80,
                      padding: EdgeInsets.all(15.0),
                      child: Image.asset('assets/images/icon-food.png'),
                    ),
                    Text(
                      'Criar uma conta',
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Ubuntu',
                        fontSize: 32.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Dados que serão utilizados para acessar o app.',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextField(
                  controller: txtUsuario,
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 22.0,
                ),
                TextField(
                  controller: txtSenha,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  buttonColor: Colors.red[800],
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 28.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      createUser(Usuario(
                          txtUsuario.text.trim(), txtSenha.text.trim()));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void createUser(Usuario usuario) async {
    try {
      db.collection('usuarios').add({
        'email': usuario.email,
        'senha': usuario.senha,
      });
    } catch (e) {
      print(e);
    }
  }
}
