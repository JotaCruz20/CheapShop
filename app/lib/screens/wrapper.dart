import 'package:app/models/user.dart';
import 'package:app/screens/authenticate/authenticate.dart';
import 'package:app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  Map data ={};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute
        .of(context)
        .settings
        .arguments;
    final user = Provider.of<User>(context);

    if (user==null){
      return Authenticate(data["storage"],data["listasFinal"]);
    }
    else{
      return Home(data["storage"],data["listasFinal"]);
    }
    //return either home or authenticate
  }
}
