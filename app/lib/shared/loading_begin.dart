import 'package:app/models/produto.dart';
import 'package:app/screens/home/LocalStorage.dart';
import 'package:app/screens/lista/listaFinal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingBegin extends StatefulWidget {
  final LocalStorage storage = new LocalStorage();

  @override
  _LoadingBeginState createState() => _LoadingBeginState();
}

class _LoadingBeginState extends State<LoadingBegin> {
  List<ListaFinal> listasFinal = [];

  Future<void> getListasFinal() async {
    bool check = await widget.storage.firstTime();
    if(check==false){
      await Navigator.pushNamed(context, '/tut');
      await widget.storage.writeFirstTime();
    }
    await widget.storage.readCounter().then((value) {
      listasFinal = value;
    });
    Navigator.pushReplacementNamed(context, "/wrapper", arguments: {
      "storage": widget.storage,
      "listasFinal": listasFinal,
    });
  }

  @override
  void initState() {
    super.initState();
    //função que faz load das cenas
    getListasFinal();
    //----------------------------------
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: SpinKitWave(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}
