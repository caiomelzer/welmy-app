import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:welmy/utils/sidebar.dart';
import 'package:welmy/services/balanca.dart';
import 'package:welmy/utils/alert.dart';
import 'package:welmy/models/Network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class BalancaPage extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<BalancaPage> {
  String _networkInterface = "";
  bool _networkBalance = false;

  String _selectedNetwork = "Rede2";
  List data = List(); //edited line
  List<DropdownMenuItem> items = [];

  
  final _formKey = GlobalKey<FormState>();

  
  @override
  initState() {
    super.initState();
    NetworkInterface.list(includeLoopback: false, type: InternetAddressType.any)
    .then((List<NetworkInterface> interfaces) {
      _networkInterface = "";
      _networkInterface = interfaces[0].addresses[0].address;
      _networkBalance = _networkInterface.contains('192.168.4.'); 
      if(_networkBalance)
        _listBalance(context);
      setState( () {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      backgroundColor: Colors.grey[350],
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
                color: Colors.grey[350],
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Text('Configurando sua Balança: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,)),
                            ), 
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                              child: Text('1 - Nas configurações do seu celular;'),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                              child: Text('2 - Conectar-se na rede com o nome "Balança_XXXX", onde XXXX é um número;'),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                              child: Text('3 - Inserir o nome da Rede e senha que a Balança irá se conectar;'),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                              child: Text('4 - Apertar o botão "Salvar";'),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                              child: Text('5 - Volte a rede Wifi que você estava utilizando antes;'),
                            ),
                          ],
                        ),
                      ),
                    ),  
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: 
                      DropdownButton(
                        isExpanded: true,
                        items: items,
                        value: _selectedNetwork,
                        onChanged: (newVal) {
                          setState(() {
                            _selectedNetwork = newVal;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child:TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Senha',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe a senha da rede';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(55, 10, 10, 0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child:RaisedButton(
                                color: Colors.grey,
                                onPressed: () {
                                  _listBalance(context);
                                },
                                child: Text(
                                  'Atualizar Redes', 
                                  style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ), 
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child:RaisedButton(
                                color: Colors.lightBlue,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _registerBalance(context);
                                  }
                                },
                                child: Text(
                                  'Conectar', 
                                  style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
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
  _registerBalance(BuildContext context) async {
    bool formOk = true;

    if (!formOk) {
      return;
    }
 
    print('dsadsdas');

    var response = await BalancaApi.register('teste','tete');
    print(response);
    Alert.showAlertDialog(context, 'Ops...', 'Algo deu errado ao tentar fazer login. Verifique seu login e senha e tente novamente','alert');
    // if(response){
    //   _navegaHomepage(context);
    // }

  }

  Future<String> _listBalance(BuildContext context) async {
    var response =  await BalancaApi.list();
    setState(() {
      data = response;
      items = data.map((item) => DropdownMenuItem(child: Text(item['name']), value: item['name'].toString())).toList();
      _selectedNetwork = data[0]["name"];
    });
  }
}