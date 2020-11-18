import 'package:app/models/produto.dart';
import 'package:app/screens/home/LocalStorage.dart';
import 'package:app/screens/lista/listaFinal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  final LocalStorage storage = new LocalStorage();

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  List<ListaFinal> listasFinal= [];

  void getListasFinal(){
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

  @override
  void initState() {
    super.initState();
    //função que faz load das cenas
    getListasFinal();
    //----------------------------------
    Navigator.pushReplacementNamed(context, "/wrapper",arguments: {
      "storage": widget.storage,
      "listasFinal": listasFinal,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}
