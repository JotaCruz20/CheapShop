import 'package:flutter/material.dart';
import 'package:app/models/produto.dart';

class ProdTileF extends StatefulWidget {
  final Produto prod;
  bool check=false;
  ProdTileF({this.prod});
  ProdTileF.C({this.prod,this.check});
  TextDecoration decor = null;

  void atulizarProd(String loja, double preco){
    prod.addLoja(loja, preco);
  }

  bool getCheck(){
    return check;
  }

  void setCheck(bool check){
    this.check=check;
  }

  Produto getProduto(){
    return prod;
  }

  @override
  _ProdTileF createState() => _ProdTileF();
}

class _ProdTileF extends State<ProdTileF> {


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
          title: Text("${widget.prod.tipo}: ${widget.prod.qntidade} unidades/kgs",
          style: TextStyle(
            decoration: widget.decor,
          ),),
          subtitle: Text(widget.prod.subtipo),
          controlAffinity: ListTileControlAffinity.trailing,
          value: widget.check,
          onChanged: (bool value) {
            setState(() {
              widget.check = value;
              widget.prod.checked = value;
              if(value==true){
                widget.decor = TextDecoration.lineThrough;
              }
              else{
                widget.decor = null;
              }
            });
          },
        ),
      ),
    );
  }
}
