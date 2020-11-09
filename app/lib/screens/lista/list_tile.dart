import 'package:flutter/material.dart';
import 'package:app/models/produto.dart';

class ProdTile extends StatefulWidget {
  final Produto prod;
  final bool inFinalList;
  bool _check=false;
  ProdTile({this.prod,this.inFinalList});

  void atulizarProd(String loja, double preco){
    prod.addLoja(loja, preco);
  }

  bool getCheck(){
    return _check;
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
    if(widget.inFinalList==false) {
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
    else{
      return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
              leading : CircleAvatar(
              radius: 25,
              backgroundColor: Colors.brown[200],
            ),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 60,
                    child: Text("${widget.prod.tipo}:\n${widget.prod.subtipo}"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Insira Quantidade Ou Kgs"
                      ),
                      validator: (String val){
                        if(double.parse(val, (e) => null) == null){
                          return "0.0";
                        }
                        else{
                          return val;
                        }
                      },
                      onChanged: (val){
                        setState(() => this.widget.prod.qntidade= double.parse(val));
                      },
                    ),
                  ),
                ]
              ),
            ),
          )
        );
    }
  }
}
