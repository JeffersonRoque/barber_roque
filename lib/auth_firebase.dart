import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

//Classe de Autenticação do Firebase
abstract class BaseAuth{
  Stream<String> get onAuthStateChanged;
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<String> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);
  }

  //Login usuário e senha
  @override
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }

  //Criar usuário e senha
  @override
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,)).user;
    return user.uid;
  }

  //Verificação de login
  @override
  Future<String> currentUser() async {
    FirebaseUser user = (await _firebaseAuth.currentUser());
    return (user != null ? user.uid: null);
  }

  //Logout
  @override
  Future<void> signOut() async{
    return _firebaseAuth.signOut();
  }

}