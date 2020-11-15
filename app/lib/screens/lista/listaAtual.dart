import 'dart:collection';
import 'package:app/screens/lista/listaFinal.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sua Lista'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context,{'nome': "Lista Inacabada",'prods':prodsAtuais,'loja':"Lista Inacabada"});
            },
          ),
        ),
      body: Form(
          key: _formKey,
          child:ListView.builder(
          itemCount: prodsAtuais.length,
          itemBuilder: (context, index) {
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 60,
                              child: Text("${prodsAtuais[index].tipo}:\n${prodsAtuais[index].subtipo}"),
                            ),
                            SizedBox(width: 0),
                            Container(
                              width: 150,
                              child: TextFormField(
                                  decoration: InputDecoration(labelText: "Insira Quantidade Ou Kgs"),
                                  validator: (val)=>double.parse(val, (e) => null) == null ? 'Insira um numero' : null,
                                  onChanged: (val){
                                    setState(() => prodsAtuais[index].qntidade= double.parse(val));
                                  },
                                ),
                              ),
                            Container(
                              width: 40,
                              child:  IconButton(
                                icon: Icon(Icons.highlight_remove_rounded),
                                color: Colors.red,
                                onPressed:(){
                                  setState(() {
                                    prodsAtuais.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                );
              }
          ),
      ),
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "btn1",
            child: Icon(Icons.done,color:Colors.white),
            backgroundColor: Colors.green[400],
            onPressed: () async{
              setState(() {
                if(_formKey.currentState.validate()) {
                  _formKey.currentState.reset();
                  precoTot.forEach((key, value) {
                    if (flag) {
                      flag = false;
                      menor = value;
                      menorLoja = key;
                    }
                    if (value < menor) {
                      menor = value;
                      menorLoja = key;
                    }
                  });
                }
              });
              print(menorLoja);
              dynamic result = await Navigator.push(context, MaterialPageRoute(
                builder: (context)=>ListaFinal(listaProds: prodsAtuais,loja:menorLoja,preco: menor),
                  ));
              Navigator.pop(context,{'nome': result['nome'],'prods':result['prods'],'loja':result['loja'],'preco':result['preco']});
              },
            ),
            SizedBox(width: 20),
            FloatingActionButton(
              heroTag: "btn2",
              child: Icon(Icons.add_shopping_cart),
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
        ]),
      );
  }
}
