import 'package:barber_roque/auth_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  //logout - usuário
  void _signOut(BuildContext context) async{
    try{
      var auth = AuthProvider.of(context).auth;
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
              onPressed: () =>_signOut(context), 
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