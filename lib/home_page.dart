import 'package:flutter/material.dart';
import 'auth_firebase.dart';

class HomePage extends StatelessWidget{
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  //logout - usuário
  void _signOut() async{
    try{
      await auth.signOut();
      onSignedOut();
    }catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Seja bem vindo !!!'),
        actions: <Widget>[
          new FlatButton(
              onPressed: _signOut, 
              child: new Text ('Logout', style: new TextStyle(fontSize: 12.0, color: Colors.white),
             )
          )
        ],
      ),
      body: new Container(
        child: new Center(
          child: new Text('Seja bem Vindo !!!', style: new TextStyle(fontSize: 32.0)),
          )
      ),
    );
  }
}