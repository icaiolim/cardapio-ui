import 'package:flutter/material.dart';

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
    },
  ));
}

class Login extends StatelessWidget {
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
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 35.0,
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Não tem uma conta? ',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 18.0,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'Cadastre-se',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
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
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/images/foto.jpg'),
                  ),
                  onTap: () {
                    final snackBar = SnackBar(content: Text("Tap"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
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
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/prate-salads.png'),
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
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Mesas',
                    style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 20.0,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.restaurant),
                            Text(
                              'Mesa 1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.restaurant),
                            Text(
                              'Mesa 2',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.restaurant),
                            Text(
                              'Mesa 3',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.restaurant),
                            Text(
                              'Mesa 4',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.restaurant),
                            Text(
                              'Mesa 5',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.restaurant),
                            Text(
                              'Mesa 6',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.restaurant),
                            Text(
                              'Mesa 7',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {},
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.restaurant),
                            Text(
                              'Mesa 8',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Sobre'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/images/foto.jpg'),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Caio Lima',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 40.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'FLUTTER DEVELOPER',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Source Sans Pro',
                fontSize: 20.0,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 150.0,
              height: 20.0,
              child: Divider(
                color: Colors.red,
              ),
            ),
            Card(
              color: Colors.red,
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  size: 30.0,
                  color: Colors.white,
                ),
                title: Text(
                  '+55 (16) 99618-7147',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              color: Colors.red,
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  size: 30.0,
                  color: Colors.white,
                ),
                title: Text(
                  'icaiolim@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
