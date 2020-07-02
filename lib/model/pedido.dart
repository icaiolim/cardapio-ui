class Pedido {

  String _id;
  String _idCardapio;
  String _item;
  int _mesa;
  int _quantidade;
  double _valor;

  Pedido(this._id, this._idCardapio, this._item, this._mesa, this._quantidade, this._valor);

  String get id => _id;
  String get idCardapio => _idCardapio;
  String get item => _item;
  int get mesa => _mesa;
  int get quantidade => _quantidade;
  double get valor => _valor;

  Pedido.map(dynamic obj){
    this._id = obj['id'] ?? '';
    this._idCardapio = obj['idCardapio'];
    this._item = obj['item'];
    this._mesa = obj['mesa'];
    this._quantidade = obj['quantidade'];
    this._valor = obj['valor'].toDouble();
  }

  //Converter os dados para um Mapa
  Map<String, dynamic> toMap(){
    var map = Map<String,dynamic>();
    if (_id != null){
      map["id"] = _id;
    }
    map["idCardapio"] = _idCardapio;
    map["item"] = _item;
    map["mesa"] = _mesa;
    map["quantidade"] = _quantidade;
    map["valor"] = _valor;

    return map;
  }

  //Converter um Mapa para o modelo de dados
  Pedido.fromMap(Map<String,dynamic> map, String id){
    //Atribuir id ao this._id, somente se id não for
    //nulo, caso contrário atribui '' (vazio).
    this._id = id ?? '';
    this._idCardapio = map["idCardapio"];
    this._mesa = map["mesa"];
    this._item = map["item"];
    this._quantidade = map["quantidade"];
    this._valor = map["valor"].toDouble();
  }

}