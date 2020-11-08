import 'package:flutter/material.dart';
import 'package:app/screens/home/home.dart';
import 'package:app/services/auth.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  final AuthService _auth = AuthService() ;

  dynamic signAnon() async{
    dynamic result = await _auth.signInAnon();
    return result;
  }

  @override
  Widget build(BuildContext context){
      dynamic result = signAnon();
      if(result == null){
        print("error");
      }
      else {
        print("LoggedIn");
        return Home();
      }
  }
}
