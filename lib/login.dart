import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/usuario.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final db = Firestore.instance;
  String outputUser = '';
  TextEditingController txtUsuario = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 45.0),
                child: Image.asset(
                  'assets/images/icon-food.png',
                  width: 100,
                ),
              ),
              Text(
                'Fazer Login',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Entrar no App',
                style: TextStyle(fontFamily: 'Ubuntu', fontSize: 18.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: txtUsuario,
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: txtSenha,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                outputUser,
                style: TextStyle(
                    color: Colors.red[800],
                    fontSize: 18.0,
                    fontFamily: 'Ubuntu'),
              ),
              SizedBox(
                height: 25.0,
              ),
              ButtonTheme(
                minWidth: double.infinity,
                buttonColor: Colors.red[800],
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  onPressed: () async {
                    var user =
                        await login(Usuario(txtUsuario.text, txtSenha.text));

                    if (user != null) {
                      Navigator.pushNamed(context, '/home');
                    } else {
                      setState(() {
                        outputUser = 'Usuário ou senha incorretos';
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 26.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Text(
                      'Criar uma conta',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/create-user');
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Usuario> login(Usuario input) async {
    var docs = await db.collection('usuarios').getDocuments();
    List<Usuario> usuarios = docs.documents
        .map((doc) => Usuario.fromMap(doc.data, doc.documentID))
        .toList();

    try {
      var user = usuarios.firstWhere((usuario) =>
          usuario.email == input.email && usuario.senha == input.senha);

      if (user == null) {
        return null;
      }

      return user;
    } catch (e) {
      return null;
    }
  }
}
