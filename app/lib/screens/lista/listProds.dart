import 'package:app/models/produto.dart';
import 'package:app/screens/lista/list_tile.dart';
import 'package:app/screens/lista/lista.dart';
import 'package:flutter/material.dart';
import 'package:app/services/database.dart';
import 'package:provider/provider.dart';

class ListaProds extends StatefulWidget {
  @override
  _ListaProdsState createState() => _ListaProdsState();
}

class _ListaProdsState extends State<ListaProds> {
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Lista de Produtos Disponiveis");
  dynamic storeList=ProdList("",[]);
  dynamic listaSelecionados = [];
  @override

  Widget build(BuildContext context) {

    return StreamProvider<List<Produto>>.value(
      value: DatabaseService().prods,
      child: Scaffold(
        backgroundColor:  Colors.brown[50],
        appBar: AppBar(
          title: appBarTitle,
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            new IconButton(icon: actionIcon,
            onPressed:(){
              setState(() {
                if ( this.actionIcon.icon == Icons.search){
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search,color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)
                    ),
                    onChanged: (string){
                      setState(() {
                        listaSelecionados=storeList.getProdsChecked();
                        storeList=ProdList(string,listaSelecionados);
                      });
                    },
                  );
                }
                else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("Lista de Produtos Disponiveis");
                }
              });
            }),
            ],
        ),
        body: storeList,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.done,color:Colors.white),
            backgroundColor: Colors.green[400],
            onPressed:(){
               Navigator.pop(context,{'list': storeList.getProdsChecked()});
            }
        ),

      ),
    );
  }

}

