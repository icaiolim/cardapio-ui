class Mesa {
  int _id;
  String _nome;
  bool _disponivel;

  Mesa(this._id, this._nome, this._disponivel);

  int get id => _id;
  String get nome => _nome;
  bool get disponivel => _disponivel;

  Mesa.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._disponivel = obj['disponivel'];
  }

  //Converter os dados para um Mapa
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }
    map["nome"] = _nome;
    map["disponivel"] = _disponivel;
    return map;
  }

  //Converter um Mapa para o modelo de dados
  Mesa.fromMap(Map<String, dynamic> map, int id) {
    //Atribuir id ao this._id, somente se id não for
    //nulo, caso contrário atribui '' (vazio).
    this._id = id ?? 0;
    this._nome = map["nome"];
    this._disponivel = map["disponivel"];
  }
}
