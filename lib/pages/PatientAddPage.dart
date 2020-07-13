import 'package:flutter/material.dart';
import 'package:welmy/pages/PatientPage.dart';
import 'package:welmy/services/login.dart';
import 'package:welmy/models/patient.dart';
import 'package:welmy/services/data.dart';
import 'package:welmy/utils/alert.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:welmy/models/patient.dart';
import 'package:welmy/pages/ListViewPatients.dart';
import 'package:welmy/pages/PatientAddPage.dart';
import 'package:welmy/services/data.dart';
import 'package:welmy/pages/home.dart';

class PatientAddPage extends StatelessWidget {
  final _ctrlUsername = TextEditingController();
  final _ctrlEmail = TextEditingController();
  final _ctrlFullname = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacientes'),
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
          tooltip: 'Previous choice',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PatientPage()));
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              _textFormField("Email", "Digite o email",
                  controller: _ctrlEmail, validator: _validaLogin),
              _textFormField("Nome Completo", "Digite o nome completo",
                  senha: false,
                  controller: _ctrlFullname,
                  validator: _validaLogin),
              _textFormField("Usuário", "Digite o nome de usuário",
                  senha: false,
                  controller: _ctrlUsername,
                  validator: _validaLogin),
              _raisedButton("Registrar", Colors.lightBlueAccent, context),
              FlatButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/pacientes');
                },
                child: Text(
                  "Cancelar",
                ),
              )
            ],
          ),
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
    if (texto.isEmpty) {
      return "Digite seu email";
    }
    if (texto.length < 3) {
      return "O campo precisa ter mais de 3 caracteres";
    }
    return null;
  }

  _raisedButton(String texto, Color cor, BuildContext context) {
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
    String fullname = _ctrlFullname.text;
    String email = _ctrlEmail.text;

    var response = await LoginApi.signup(username, 'usernovo', fullname, email);

    var patient = new Patient();
    patient.fullname = fullname;

    if (response) {
      await DataApi.getPatientFullname().then((value) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PatientPage()));
      });
    } else
      Alert.showAlertDialog(
          context,
          'Ops...',
          'Algo deu errado ao tentar fazer login. Verifique seu login e senha e tente novamente',
          'alert');
  }
}
