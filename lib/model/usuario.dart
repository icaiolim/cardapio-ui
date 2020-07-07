class Usuario {
  String _id;
  String _email;
  String _senha;

  Usuario(this._email, this._senha);

  String get email => this._email;
  String get senha => this._senha;

  Usuario.map(dynamic obj) {
    this._email = obj['email'];
    this._senha = obj['senha'];
  }

  //Converter os dados para um Mapa
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }
    map["email"] = _email;
    map["senha"] = _senha;
    return map;
  }

  //Converter um Mapa para o modelo de dados
  Usuario.fromMap(Map<String, dynamic> map, String id) {
    //Atribuir id ao this._id, somente se id não for
    //nulo, caso contrário atribui '' (vazio).
    this._id = id ?? '';
    this._email = map["email"];
    this._senha = map["senha"];
  }
}
