import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

//Tipo de Formulários
enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage>{

  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  //Ação do Botão
  void validateAndSubmit() async{
    if (validateAndSave()){
      try{
        if(_formType == FormType.login){
          final FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
          print('Signed in: ${user.uid}');
        }else{
          final FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password,)).user;
          print('Registered in: ${user.uid}');
        }
      }
      catch (e){
        print('Error $e');
      }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  //Conteúdo da Página
  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(title: new Text('Login')
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0), //Distancia entre os formulários
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, //posição do botão
              children: buildInputs() + buildSubmitButton(),
            ),
          ),
        ),
      );
    }

    // Formulários
    List<Widget> buildInputs(){
      return [
        //e-mail
        new TextFormField(
          decoration: new InputDecoration(labelText: 'e-mail:'),
          validator: (value) => value.isEmpty ? "e-mail obrigatório !" : null,
          onSaved: (value) => _email = value,
        ),
        //senha
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Senha:'),
          obscureText: true,
          validator: (value) => value.isEmpty ? "senha obrigatória !" : null,
          onSaved: (value) => _password = value,
        ),
      ];
    }

    //Botões
    List<Widget> buildSubmitButton(){
      if(_formType == FormType.login){
        return [
          //Login
          new RaisedButton(
            child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
            onPressed: validateAndSubmit,
          ),
          //Criar uma conta
          new FlatButton(
            onPressed: moveToRegister, 
            child: new Text('Criar uma conta', style: new TextStyle(fontSize: 20.0)),
          ),
        ];
      } else{
        return [
          //Criar conta
          new RaisedButton(
            child: new Text('Criar conta', style: new TextStyle(fontSize: 20.0)),
            onPressed: validateAndSubmit,
          ),
          //Retornar
          new FlatButton(
            onPressed: moveToLogin, 
            child: new Text('Já possui uma conta? Login', style: new TextStyle(fontSize: 20.0)),
          ),
        ];
      }
      
    }
}
