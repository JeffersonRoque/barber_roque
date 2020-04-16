import 'package:barber_roque/auth_provider.dart';
import 'package:flutter/material.dart';
import 'auth_firebase.dart';
import 'login_page.dart';
import 'home_page.dart';

class RootPage extends StatelessWidget{
 
  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = AuthProvider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final bool isLoggedIn = snapshot.hasData;
          return isLoggedIn ? HomePage() : LoginPage();
        }
        return _buildWaitingScreen();
      },
    );
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}