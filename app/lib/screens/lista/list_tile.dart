import 'package:flutter/material.dart';
import 'package:mockup_app/models/produto.dart';

class ProdTile extends StatelessWidget {
  final Produto prod;
  final bool inFinalList;

  ProdTile({this.prod,this.inFinalList});

  void atulizarProd(String loja, double preco){
    this.prod.addLoja(loja, preco);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[200],
          ),
          title: Text(prod.tipo),
          subtitle: Text(prod.subtipo),
          onTap:(){
            if(inFinalList==false) {
              Navigator.pop(context, {
                'prod': this.prod,
              });
            }
          },
        ),
      ),
    );
  }
}
