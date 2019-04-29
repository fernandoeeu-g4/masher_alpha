import 'package:flutter/material.dart';

import '../Auth.dart';

class SignInWithEmail extends StatefulWidget {
  SignInWithEmail({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => _SignInWithEmailState();
}

enum FormType { login, register }

class _SignInWithEmailState extends State<SignInWithEmail> {
  final formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _checkPasswordController = TextEditingController();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _checkPasswordController.dispose();
    super.dispose();
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId =
              await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        } else {
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
          print('registered: $userId');
        }
      } catch (err) {
        print(err);
      }
    } else {
      print('usuário nao cadastrado');
    }
  }

  void switchLoginType(String type) {
    formKey.currentState.reset();
    switch (type) {
      case 'login':
        setState(() {
          _formType = FormType.login;
        });
        break;
      case 'register':
        setState(() {
          _formType = FormType.register;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login com email"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          // formulário para login com email via Firebase...
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: defaultInputs() + registerInputs() + buildButtons(),
          ),
        ),
      ),
    );
  } // fim do método build

  List<Widget> defaultInputs() {
    return [
      TextFormField(
        controller: _emailController,
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'Email é obrigatório' : null,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(labelText: 'Senha'),
        validator: (value) => value.isEmpty ? 'Senha é obrigatória' : null,
        onSaved: (value) => _password = value,
        obscureText: true,
      ),
    ];
  }

  List<Widget> registerInputs() {
    if (_formType == FormType.register) {
      return [
        TextFormField(
          controller: _checkPasswordController,
          decoration: InputDecoration(labelText: 'Repita sua senha'),
          validator: (value) {
            if (value != _passwordController.text) {
              return 'As senhas não são idênticas';
            }
          },
          onSaved: (value) => _password = value,
          obscureText: true,
        ),
      ];
    } else {
      return [];
    }
  }

  List<Widget> buildButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          color: Color(0xffE11948),
          onPressed: () => validateAndSubmit(),
          child: Text(
            'Entrar',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
        FlatButton(
          onPressed: () => switchLoginType('register'),
          child: Text(
            'Criar Conta',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ];
    } else {
      return [
        RaisedButton(
          color: Color(0xffE11948),
          onPressed: () => validateAndSubmit(),
          child: Text(
            'Cadastrar',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
        FlatButton(
          onPressed: () => switchLoginType('login'),
          child: Text(
            'Já sou cadastrado',
            style: TextStyle(fontSize: 20.0),
          ),
        )
      ];
    }
  }
}
