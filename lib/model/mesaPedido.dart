import 'mesa.dart';
import 'pedido.dart';

class MesaPedido {
  Mesa _mesa;
  Pedido _pedido;

  MesaPedido(this._mesa, this._pedido);

  Mesa get mesa => this._mesa;
  Pedido get pedido => this._pedido;
}
