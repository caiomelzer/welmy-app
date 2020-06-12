import 'package:flutter/material.dart';
import 'package:welmy/pages/home.dart';
import 'package:welmy/services/login.dart';
import 'package:welmy/pages/signin.dart';


class SignupPage extends StatelessWidget {
  
  final _ctrlUsername = TextEditingController();
  final _ctrlPassword = TextEditingController();
  final _ctrlEmail = TextEditingController();
  final _ctrlFullname = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      backgroundColor: Colors.grey[350],
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            new Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: new Stack(
                    children: <Widget>[
                      new Image.asset(
                        'assets/images/logo.png',
                        width: 200.0,
                        height: 100.0,
                      ),
                    ],
                  ),
                ),
              ),
            _textFormField(
              "Email",
              "Digite seu email",
              controller: _ctrlEmail,
              validator : _validaLogin
            ),
            _textFormField(
              "Nome Completo",
              "Digite seu nome completo",
              senha: false,
              controller: _ctrlFullname,
              validator : _validaLogin
            ),
            _textFormField(
              "Usuário",
              "Digite seu nome de usuário",
              senha: false,
              controller: _ctrlUsername,
              validator : _validaLogin
            ),
            _textFormField(
              "Senha",
              "Digite a Senha",
              senha: true,
              controller: _ctrlPassword,
              validator : _validaSenha
            ),
            _raisedButton("Registrar", Colors.lightBlueAccent, context),
            FlatButton(
              onPressed: () {
                Navigator.popAndPushNamed( 
                  context,
                  '/signin'
                );
              },
              child: Text(
                "Voltar",
              ),
            )
        ],
        ),
      ),
    );
  }

  _textFormField(
    String label,
    String hint, {
    bool senha = false,
    TextEditingController controller,
    FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: senha,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
    );
  }

  String _validaLogin(String texto) {
    if(texto.isEmpty){
      return "Digite seu email";
    }
    if(texto.length<3){
      return "O campo precisa ter mais de 3 caracteres";
    }
    return null;
  }

  String _validaSenha(String texto) {
    if(texto.isEmpty){
      return "Digite a Senha";
    }
    return null;
  }

  _raisedButton(
    String texto, 
    Color cor, 
    BuildContext context) {
    return RaisedButton(
      color: cor,
      child: Text(
        texto,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      onPressed: () {
        _clickButton(context);
      },
    );
  }

   _clickButton(BuildContext context) async {
    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    String username = _ctrlUsername.text;
    String password = _ctrlPassword.text;
    String fullname = _ctrlFullname.text;
    String email = _ctrlEmail.text;


    var response = await LoginApi.signup(username,password,fullname,email);
    
    if(response){
      _navegaHomepage(context);
    }

  }

  _navegaHomepage(BuildContext context){
    Navigator.popAndPushNamed( 
      context,
      '/home'
    );
  }

}