import 'package:flutter/material.dart';
import 'package:app/models/produto.dart';

class ProdTile extends StatefulWidget {
  final Produto prod;
  bool _check=false;
  ProdTile({this.prod});

  void atulizarProd(String loja, double preco){
    prod.addLoja(loja, preco);
  }

  bool getCheck(){
    return _check;
  }

  void setCheck(bool check){
    this._check=check;
  }

  Produto getProduto(){
    return prod;
  }

  @override
  _ProdTile createState() => _ProdTile();
}

class _ProdTile extends State<ProdTile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: CheckboxListTile(
          secondary: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[200],
          ),
          title: Text(widget.prod.tipo),
          subtitle: Text(widget.prod.subtipo),
          controlAffinity: ListTileControlAffinity.trailing,
          value: widget._check,
          onChanged: (bool value) {
            setState(() {
              widget._check = value;
            });
          },
        ),
      ),
    );
  }
}
