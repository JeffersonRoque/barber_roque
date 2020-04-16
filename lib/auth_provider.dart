import 'package:barber_roque/auth_firebase.dart';
import 'package:flutter/material.dart';

class AuthProvider extends InheritedWidget{
  AuthProvider({Key key, Widget child, this.auth}) : super(key: key, child: child);
  final BaseAuth auth;


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuthProvider of(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<AuthProvider>());
  }
}
