import 'package:flutter/material.dart';
import 'login_page.dart';
import 'auth_firebase.dart';
import 'home_page.dart';

//Classe Raiz - Intermédio entre home e Login Page
class RootPage extends StatefulWidget{
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

//tipos de status
enum AuthStatus{
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage>{

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  //Verifica se o usuário já esta logado
  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId){
      setState((){
        _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  //Atualiza caso o usuário logar
  //Logado
  void _signedIn(){
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  //Não Logado
  void _signedOut(){
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  //Endereçamento do usuário
  @override
  Widget build(BuildContext context) {
    switch (_authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
          );
      case AuthStatus.signedIn:
        return new Scaffold(
          body: new HomePage(
            auth: widget.auth,
            onSignedOut: _signedOut,
          ),
        );
    }
    return null;
  }
}