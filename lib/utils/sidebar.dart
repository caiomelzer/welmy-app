import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welmy/pages/signin.dart';
import 'package:welmy/pages/balanca.dart';
import 'package:welmy/pages/home.dart';
import 'package:welmy/pages/about.dart';
import 'package:welmy/models/patient.dart';
import 'package:welmy/services/data.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Olá Usuário',
              style: TextStyle(color: Colors.lightBlue, fontSize: 25),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              var patient = new Patient();
              DataApi.getPatientFullname().then((value) {
                patient.fullname = value;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomePage(patient)));
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurar Balança'),
            onTap: () => {Navigator.popAndPushNamed(context, '/balanca')},
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Sobre'),
            onTap: () => {Navigator.popAndPushNamed(context, '/sobre')},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () =>
                {logout(), Navigator.popAndPushNamed(context, '/signin')},
          ),
        ],
      ),
    );
  }

  Future logout() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.clear();
    } catch (e) {}
  }
}
