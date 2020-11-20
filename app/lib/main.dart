import 'package:app/models/user.dart';
import 'package:app/screens/home/home.dart';
import 'package:app/screens/home/tutPage.dart';
import 'package:app/screens/lista/listProds.dart';
import 'package:app/screens/lista/listaAtual.dart';
import 'package:app/screens/lista/listaFinal.dart';
import 'package:app/screens/wrapper.dart';
import 'package:app/services/auth.dart';
import 'package:app/shared/loading_begin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        routes: {
          '/' :(context) => LoadingBegin(),
          '/wrapper' :(context) => Wrapper(),
          '/newlist': (context) => ListaAtual(),
          '/list': (context) => ListaProds(),
          '/listFinal': (context) => ListaFinal(),
          '/tut':(context)=>OnBoardingPage(),
        },
      ),
    );
  }
}
