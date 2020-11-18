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
    await widget.storage.readCounter().then((value) {
      listasFinal = value;
    });
  }

  @override
  void initState() {
    super.initState();
    //função que faz load das cenas
    getListasFinal();
    //----------------------------------
    Future.delayed(Duration(seconds:5), () {
      Navigator.pushReplacementNamed(context, "/wrapper", arguments: {
        "storage": widget.storage,
        "listasFinal": listasFinal,
      });
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
