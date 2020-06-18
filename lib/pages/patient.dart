import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:welmy/utils/sidebar.dart';
import 'package:welmy/services/balanca.dart';
import 'package:welmy/utils/alert.dart';
import 'package:welmy/models/Network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';





class PatientPage extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<PatientPage> {
  final List<String> items = <String>['Dia','Semana','Mes'];

  @override
  initState() {
    super.initState();  
  }
  
  @override
  List<String> entries = <String>['A', 'B', 'C1', 'B', 'C1', 'B', 'C', 'B', 'C', 'B', 'C'];
  List<int> colorCodes = <int>[600, 500, 100];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
          title: Text('te'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            print( entries.length);
            return Container(
              height: 50,
              color: Colors.amber[colorCodes[index]],
              child: Center(child: Text('Entry ${entries[index]}')),
            );
          }
        )
    );
  }


}