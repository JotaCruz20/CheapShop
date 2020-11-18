import 'package:app/models/produto.dart';
import 'package:app/screens/home/LocalStorage.dart';
import 'package:app/screens/lista/listProds.dart';
import 'package:app/screens/lista/listaAtual.dart';
import 'package:app/screens/lista/listaFinal.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  LocalStorage storage;
  List<ListaFinal> listasFinal= [];

  Home(LocalStorage storage,List<ListaFinal> listasFinal){
    this.storage=storage;
    this.listasFinal=listasFinal;
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  {
  List<ListaFinal> listasFinal;

  @override

  void initState() {
    super.initState();
  }


  Widget build(BuildContext context) {
    listasFinal= widget.listasFinal;
    return Scaffold(
      backgroundColor:  Colors.brown[50],
      appBar: AppBar(
        title: Text('Shopping List'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add list'),
            onPressed: () async{
              dynamic result = await Navigator.push(context, MaterialPageRoute(
                builder: (context)=>ListaAtual(prodsAtuais: []),
              ));
              ListaFinal list = ListaFinal(listaProds:result['prods'],loja:result['loja'],preco:result['preco']);
              list.setNome(result['nome']);
              setState(() {
                listasFinal.add(list);
              });
              return  widget.storage.writeCounter(listasFinal);
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: listasFinal.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
                margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                child: ListTile(
                  title: Text(listasFinal[index].nome),
                  subtitle: Text(listasFinal[index].loja),
                  onTap: (() async{
                    if(listasFinal[index].loja=="Lista Inacabada"){
                      return showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Lista Inacabada!'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Tem de Acabar a lista para poder continuar.'),
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
                      ListaFinal f = ListaFinal(preco: listasFinal[index].preco,
                          listaProds: listasFinal[index].listaProds,
                          loja: listasFinal[index].loja);
                      f.setNome(listasFinal[index].nome);
                      dynamic result = await Navigator.push(
                          context, MaterialPageRoute(
                        builder: (context) => f,
                      ));
                      setState(() {
                        f = ListaFinal(preco: result['preco'],
                            listaProds: result['prods'],
                            loja: result['loja']);
                        f.setNome(result['nome']);
                        listasFinal.removeAt(index);
                        listasFinal.insert(index, f);
                      });
                      return widget.storage.writeCounter(listasFinal);
                    }
                  }),
                  trailing: Container(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.orange[300],
                            onPressed: () async{
                              dynamic result = await Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>ListaAtual(prodsAtuais: listasFinal[index].listaProds),
                              ));
                              setState(() {
                                ListaFinal f= ListaFinal(preco: result['preco'],listaProds: result['prods'],loja:result['loja']);
                                f.setNome(result['nome']);
                                listasFinal.removeAt(index);
                                listasFinal.insert(index, f);
                              });
                              return  widget.storage.writeCounter(listasFinal);
                            }
                        ),
                        IconButton(
                          icon: Icon(Icons.highlight_remove_rounded),
                          color: Colors.red,
                          onPressed: (){
                            setState(() {
                              listasFinal.removeAt(index);
                            });
                            return  widget.storage.writeCounter(listasFinal);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
