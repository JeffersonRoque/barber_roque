import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

//Classe de Autenticação do Firebase
abstract class BaseAuth{
  Future<String> singInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Login usuário e senha
  Future<String> singInWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }

  //Criar usuário e senha
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,)).user;
    return user.uid;
  }

  //Verificação de login
  Future<String> currentUser() async {
    FirebaseUser user = (await _firebaseAuth.currentUser());
    return (user != null ? user.uid: null);
  }

  //Logout
  Future<void> signOut() async{
    return _firebaseAuth.signOut();
  }

}