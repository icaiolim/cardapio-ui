class ItemCardapio {
  String _id;
  String _nome;
  double _valor;
  String _imagem;

  ItemCardapio(this._id, this._nome, this._valor, this._imagem);

  String get id => this._id;
  String get nome => this._nome;
  double get valor => this._valor;
  String get imagem => this._imagem;

  set id(String id) => this._id = id;
  set nome(String nome) => this._nome = nome;
  set valor(double valor) => this._valor = valor;
  set imagem(String imagem) => this._imagem = imagem;

  ItemCardapio.map(dynamic obj) {
    this._id = obj['id'] ?? '';
    this._nome = obj['Nome'];
    this._valor = obj['Valor'].toDouble();
    this._imagem = obj['Imagem'];
  }

  //Converter os dados para um Mapa
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }

    map["Nome"] = _nome;
    map["Valor"] = _valor;
    map["Imagem"] = _imagem;

    return map;
  }

  //Converter um Mapa para o modelo de dados
  ItemCardapio.fromMap(Map<String, dynamic> map, String id) {
    //Atribuir id ao this._id, somente se id não for
    //nulo, caso contrário atribui '' (vazio).
    this._id = id ?? '';
    this._nome = map["Nome"];
    this._valor = map["Valor"].toDouble();
    this._imagem = map["Imagem"];
  }
}
