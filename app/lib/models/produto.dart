import 'dart:collection';

class Produto{
  final String tipo;
  final String subtipo;
  final double preco;
  final String loja;
  HashMap lojaPreco = new HashMap();

  Produto({this.tipo,this.subtipo,this.preco,this.loja});

  void addLoja(String loja,double preco){
    lojaPreco.addAll({loja:preco});
  }

}