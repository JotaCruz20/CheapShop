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
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Final'),
        backgroundColor: Colors.brown[400],
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
                  SizedBox(height: 10),
                  Text("A loja mais barata é\n      ${widget.loja}.\n     Total de ${widget.preco}€ *",
                  style: TextStyle(
                    color:Colors.green[500],
                    fontSize: 30,
                      ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                      child: ListView.builder(
                      itemCount: widget.listaProds.length,
                      itemBuilder: (context, index) {
                        ProdTileF tile = ProdTileF.C(prod: widget.listaProds[index],check:widget.listaProds[index].checked);
                        return Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: tile,
                        );
                      }
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("* O preço é calculado com base em preços online pode haver algumas divergencias",
                  style: TextStyle(
                    color:Colors.green[300],
                    fontSize: 15,
                  ),
                  )
                ]
              ),
      ),
    );
  }
}
