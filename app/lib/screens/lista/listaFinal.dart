import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:app/models/produto.dart';

import 'list_tile.dart';
import 'list_tile_Final.dart';


class ListaFinal extends StatefulWidget {
  final List<Produto> listaProds;
  final String loja;
  final double preco;
  String nome;
  ListaFinal({this.listaProds,this.loja,this.preco});

  void setNome(String nome){
    this.nome = nome;
  }

  @override
  _ListaFinalState createState() => _ListaFinalState();
}

class _ListaFinalState extends State<ListaFinal> {
  bool flag = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:new BoxDecoration(
          image:  new DecorationImage(
            image: new AssetImage("assets/background/day.png"),
            fit: BoxFit.cover,)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Lista Final'),
          backgroundColor: Colors.lightGreen[900],
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              if(_formKey.currentState.validate()){
                Navigator.pop(context,{'nome': widget.nome,'prods':widget.listaProds,'loja':widget.loja,'preco':widget.preco});
              }
            },
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.done,color:Colors.white),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    Navigator.pop(context,{'nome': widget.nome,'prods':widget.listaProds,'loja':widget.loja,'preco':widget.preco});
                  }
                }
            ),
          ],
        ),
        body: Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child:TextFormField(
                          decoration: InputDecoration(labelText: "Insira Nome da Lista"),
                          validator: (val)=> val.isEmpty ? 'Insira um nome' : null,
                          initialValue: widget.nome,
                          onChanged: (val){
                            widget.nome = val;
                          },
                        ),
                      ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 40,
                      child: Text("A loja mais barata é:\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Open Sans",
                        color:Colors.green[500],
                        fontSize: 30,
                          ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Text("${widget.loja}\n",
                      textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600],
                          fontSize: 50,
                          fontFamily: "BalooTamma2"
                        ),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                        itemCount: widget.listaProds.length,
                        itemBuilder: (context, index) {
                          ProdTileF tile = ProdTileF(prod: widget.listaProds[index]);
                          tile.setCheck(widget.listaProds[index].checked);
                          return Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: tile,
                          );
                        }
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Total de ${widget.preco}€ *",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600],
                          fontSize: 30,
                          fontFamily: "BalooTamma2"
                      ),
                    ),
                    Text("* O preço é calculado com base em preços online pode haver algumas divergências",
                    style: TextStyle(
                      fontFamily: "Open Sans",
                      color:Colors.green[300],
                      fontSize: 15,
                    ),
                    )
                  ]
                ),
        ),
      ),
    );
  }
}
