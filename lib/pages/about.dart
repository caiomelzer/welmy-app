import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welmy/utils/sidebar.dart';


class AboutPage extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}



class _ScanState extends State<AboutPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      backgroundColor: Colors.blueGrey[900],
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                color: Colors.grey[350],
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset('assets/images/logo.png', height: 25,), 
                        ), 
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            iconSize: 40,
                            color: Colors.black38,
                            icon: Icon(Icons.view_headline),
                            tooltip: '',
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          )
                        ), 
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(text: 'Política de Privacidade: \n', style: TextStyle(fontWeight: FontWeight.bold)), 
                              TextSpan(text: 'Este Aplicativo recolhe alguns Dados Pessoais dos Usuários.\n'),
                              TextSpan(text: '\nOs Dados Pessoais são coletados para os seguintes propósitos e usando os seguintes serviços: \n', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: 'Guardamos dados pessoais como: Nome Completo e Email\n'),
                              TextSpan(text: 'Amazon Web Services (AWS): Dados Pessoais: vários tipos de Dados como especificados na política de privacidade do serviço\n'),
                              TextSpan(text: '\nInformação de contato: \n', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: 'IoGÁS - Rua Antonio das Chagas 828, 04714-001, SP, Brazil\n'),
                              TextSpan(text: 'contato@iogas.com.br\n'),
                            ],
                          ),
                        ),
                      ), 
                    ),
                  ],
                ),
              ),
              
            ],
          );
        }
      )
    );
  }

}