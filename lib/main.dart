import 'package:barber_roque/auth_provider.dart';
import 'package:flutter/material.dart';
import 'auth_firebase.dart';
import 'root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{

  @override
    Widget build(BuildContext context){
      return AuthProvider(
        auth: Auth(),
        child: MaterialApp(
          title: "Roque Barbearia login",
          theme: new ThemeData(
            primarySwatch: Colors.blue, 
          ),
          home: new RootPage(), //Pagina principal
        )
      );
    }
}
