import 'package:barber_roque/auth_provider.dart';
import 'package:flutter/material.dart';

class EmailFielValidadator {
  static String validade(String value) =>
      value.isEmpty ? "e-mail obrigatório !" : null;
}

class PasswordFielValidador {
  static String validade(String value) =>
      value.isEmpty ? "senha obrigatória !" : null;
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

//Tipo de Formulários
enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //Autenticação
  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        var auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          String userId =
              (await auth.signInWithEmailAndPassword(_email, _password));
          print('Signed in: $userId');
        } else {
          String userId =
              (await auth.createUserWithEmailAndPassword(_email, _password));
          print('Registered in: $userId');
        }
      } catch (e) {
        print('Error $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  //Conteúdo da Página
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/barber.jpg"),
          fit: BoxFit.cover,
        )),
        padding: EdgeInsets.all(16.0), //Distancia entre os formulários
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: new Form(
            key: formKey,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch, //posição do botão
              children: buildInputs() + buildSubmitButton(),
            ),
          ),
        ),
      ),
    );
  }

  // Formulários
  List<Widget> buildInputs() {
    return [
      //e-mail
      new TextFormField(
        key: Key('email'),
        decoration: new InputDecoration(
          labelText: 'e-mail:',
          // labelStyle: TextStyle(
          //   color: Colors.white,
          //   fontWeight: FontWeight.bold,
          // ),
        ),
        validator: EmailFielValidadator.validade,
        onSaved: (value) => _email = value,
      ),
      //senha
      new TextFormField(
        key: Key('password'),
        decoration: new InputDecoration(labelText: 'Senha:'),
        obscureText: true,
        validator: PasswordFielValidador.validade,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  //Botões
  List<Widget> buildSubmitButton() {
    if (_formType == FormType.login) {
      return [
        //Login
        new RaisedButton(
          key: Key('signIn'),
          child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        //Criar uma conta
        new FlatButton(
          onPressed: moveToRegister,
          child: new Text('Registrar', style: new TextStyle(fontSize: 20.0)),
        ),
      ];
    } else {
      return [
        //Criar conta
        new RaisedButton(
          child: new Text('Criar conta', style: new TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        //Retornar
        new FlatButton(
          onPressed: moveToLogin,
          child: new Text('Voltar', style: new TextStyle(fontSize: 20.0)),
        ),
      ];
    }
  }
}
