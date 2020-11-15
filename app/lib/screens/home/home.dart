import 'package:app/models/produto.dart';
import 'package:app/screens/home/LocalStorage.dart';
import 'package:app/screens/lista/listProds.dart';
import 'package:app/screens/lista/listaFinal.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  final LocalStorage storage = new LocalStorage();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  {
  List<ListaFinal> listasFinal= [];

  @override

  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        listasFinal = value;
      });
      setState(() {
        if(listasFinal==[]){
          List<Produto> prodTest = [];
          Produto test = Produto(tipo: "Tipo do Produto", subtipo: "Subtipo do Produto",preco: 0.0,loja: 'Loja');
          prodTest.add(test);
          ListaFinal teste=ListaFinal(loja:"Tutorial",preco: 0,listaProds: prodTest);
          listasFinal.add(teste);
        }
      });
    });
  }


  Widget build(BuildContext context) {


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
              dynamic result = await Navigator.pushNamed(context, '/newlist');
              ListaFinal list = ListaFinal(listaProds:result['prods'],loja:result['loja'],preco:result['preco']);
              list.setNome(result['nome']);
              setState(() {
                listasFinal.add(list);
              });
              return  widget.storage.writeCounter(listasFinal);
            },
          ),
          FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: (){
              }
          )
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
                    ListaFinal f= ListaFinal(preco: listasFinal[index].preco,listaProds: listasFinal[index].listaProds,loja:listasFinal[index].loja);
                    f.setNome(listasFinal[index].nome);
                    await Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>f,
                    ));
                  }),
                ),
              ),
            );
          }),
    );
  }
}
