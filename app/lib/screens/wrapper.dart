import 'package:app/models/user.dart';
import 'package:app/screens/authenticate/authenticate.dart';
import 'package:app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user==null){
      return Authenticate();
    }
    else{
      return Home();
    }
    //return either home or authenticate
  }
}
