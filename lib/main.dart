import 'package:flutter/material.dart';

import 'about.dart';
import 'cadastro-pedido.dart';
import 'cadastro-usuario.dart';
import 'home.dart';
import 'login.dart';
import 'food-table.dart';

void main() {
  runApp(MaterialApp(
    title: 'Cardapio App',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    initialRoute: '/login',
    routes: {
      '/login': (context) => Login(),
      '/home': (context) => MyApp(),
      '/about': (context) => About(),
      '/table': (context) => FoodTable(),
      '/cadastro': (context) => TelaCadastro(),
      '/create-user': (context) => CreateUser(),
    },
  ));
}
