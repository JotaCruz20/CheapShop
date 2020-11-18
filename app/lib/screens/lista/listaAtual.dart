import 'dart:collection';
import 'package:app/screens/lista/listaFinal.dart';
import 'package:app/shared/loading_next_page.dart';
import 'package:flutter/material.dart';
import 'package:app/models/produto.dart';
import 'package:app/screens/lista/list_tile.dart';

class ListaAtual extends StatefulWidget {
  List<Produto> prodsAtuais =[];
  HashMap precoTot = new HashMap();

  ListaAtual({this.prodsAtuais});

  @override
  _ListaAtualState createState() => _ListaAtualState();
}

class _ListaAtualState extends State<ListaAtual> {

  double menor = 0;
  String menorLoja='';
  bool flag = true;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? LoadingPage() : Scaffold(
        appBar: AppBar(
          title: Text('Sua Lista'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context,{'nome': "Lista Inacabada",'prods':widget.prodsAtuais,'loja':"Lista Inacabada"});
            },
          ),
        ),
      body: Form(
          key: _formKey,
          child:ListView.builder(
          itemCount: widget.prodsAtuais.length,
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
                              child: Text("${widget.prodsAtuais[index].tipo}:\n${widget.prodsAtuais[index].subtipo}"),
                            ),
                            SizedBox(width: 0),
                            Container(
                              width: 150,
                              child: TextFormField(
                                  decoration: InputDecoration(labelText: "Insira Quantidade Ou Kgs"),
                                  validator: (val)=>double.parse(val, (e) => null) == null ? 'Insira um numero' : null,
                                  initialValue: "${widget.prodsAtuais[index].qntidade}",
                                  onChanged: (val){
                                    setState(() => widget.prodsAtuais[index].qntidade= double.parse(val));
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
                                    widget.prodsAtuais.removeAt(index);
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
            onPressed: () async {
                setState(() {
                  loading=true;
                });
                if(widget.prodsAtuais.length==0){
                  return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Lista sem Itens!'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Lista sem itens.'),
                                Text('Adicione itens para poder continuar'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      }
                  );
                }
                else {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _formKey.currentState.reset();
                      //calcula
                      widget.prodsAtuais.forEach((element) {
                        element.lojaPreco.forEach((key, value) {
                          if (widget.precoTot.containsKey(key)) {
                            widget.precoTot.update(key, (val) =>
                            value.toDouble() * element.qntidade +
                                val.toDouble());
                          }
                          else {
                            widget.precoTot.addAll(
                                { key: value.toDouble() * element.qntidade});
                          }
                        });
                        if (widget.precoTot.containsKey(element.loja)) {
                          widget.precoTot.update(element.loja, (value) =>
                          value.toDouble() +
                              element.preco.toDouble() * element.qntidade);
                        }
                        else {
                          widget.precoTot.addAll({
                            element.loja: element.preco.toDouble() *
                                element.qntidade
                          });
                        }
                      });
                      //**menor
                      widget.precoTot.forEach((key, value) {
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
                    });
                    dynamic result = await Navigator.push(
                        context, MaterialPageRoute(
                      builder: (context) => ListaFinal(
                          listaProds: widget.prodsAtuais,
                          loja: menorLoja,
                          preco: menor),
                    ));
                    Navigator.pop(context, {
                      'nome': result['nome'],
                      'prods': result['prods'],
                      'loja': result['loja'],
                      'preco': result['preco']
                    });
                  }
                }
                setState(() {
                  loading=false;
                });
            }),
            SizedBox(width: 20),
            FloatingActionButton(
              heroTag: "btn2",
              child: Icon(Icons.add_shopping_cart),
              onPressed: () async{
                setState(() {
                  loading=true;
                });
                dynamic result = await Navigator.pushNamed(context, '/list');
                setState(() {
                  for(var i=0;i<result['list'].length;i++) {
                    Produto prod = result['list'][i].getProduto();
                    prod.setChecked(false);
                    widget.prodsAtuais.add(prod);
                  }
                  loading=false;
                });
              },
            ),
        ]),
      );
  }
}
