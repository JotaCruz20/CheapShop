import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:app/models/produto.dart';
import 'package:app/screens/lista/list_tile.dart';

class ListaAtual extends StatefulWidget {
  @override
  _ListaAtualState createState() => _ListaAtualState();
}

class _ListaAtualState extends State<ListaAtual> {
  List<Produto> prodsAtuais =[];
  HashMap precoTot = new HashMap();
  double menor = 0;
  String menorLoja='';
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sua Lista'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            new  FlatButton.icon(
              label: Text('Add'),
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () async{
                dynamic result = await Navigator.pushNamed(context, '/list');
                setState(() {
                  for(var i=0;i<result['list'].length;i++) {
                    Produto prod = result['list'][i].getProduto();
                    prodsAtuais.add(prod);
                    prod.lojaPreco.forEach((key, value) {
                      if (precoTot.containsKey(key)) {
                        precoTot.update(key, (val) =>
                        value.toDouble() + val.toDouble());
                      }
                      else {
                        precoTot.addAll({ key: value.toDouble()});
                      }
                    });
                    if (precoTot.containsKey(prod.loja)) {
                      precoTot.update(
                          prod.loja, (value) => value.toDouble() +
                          prod.preco.toDouble());
                    }
                    else {
                      precoTot.addAll({
                        prod.loja: prod.preco.toDouble()
                      });
                    }
                  }
                });
              },
            ),
            new  FlatButton.icon(
              label: Text('Finish'),
              icon: Icon(Icons.done),
              onPressed: () async{
                setState(() {
                  precoTot.forEach((key, value) {
                    if(flag){
                      flag=false;
                      menor=value;
                    }
                    if(value<menor){
                      menor=value;
                      menorLoja=key;
                    }
                  });
                  print(menorLoja);
                });
              },
            ),
          ],
        ),
      body: ListView.builder(
          itemCount: prodsAtuais.length,
          itemBuilder: (context, index) {
              print(prodsAtuais[index].lojaPreco);
              return ProdTile(prod: prodsAtuais[index], inFinalList: true,);
            }
          ),
      );
  }
}
