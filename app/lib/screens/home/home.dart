import 'package:app/services/auth.dart';
import 'package:app/screens/lista/lista.dart';
import 'package:flutter/material.dart';
import 'package:app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
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
      );
  }
}
