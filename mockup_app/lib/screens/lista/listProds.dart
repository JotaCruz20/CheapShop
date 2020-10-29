import 'package:mockup_app/models/produto.dart';
import 'package:mockup_app/screens/lista/lista.dart';
import 'package:flutter/material.dart';
import 'package:mockup_app/services/database.dart';
import 'package:provider/provider.dart';

class ListaProds extends StatefulWidget {
  @override
  _ListaProdsState createState() => _ListaProdsState();
}

class _ListaProdsState extends State<ListaProds> {
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Lista de Produtos Disponiveis");
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
        body: ProdList(),
      ),
    );
  }

}

