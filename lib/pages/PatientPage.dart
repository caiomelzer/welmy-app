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

List<Patient> parsePatients(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Patient>((json) => Patient.fromJson(json)).toList();
}

Future<List<Patient>> fetchPatients(http.Client client) async {
  var token = await DataApi.getToken();
  var userId = await DataApi.getUserId();
  var header = {"x-access-token": "$token", "Content-Type": "application/json"};
  final response = await client.get(
      'http://welmy.iogas.com.br:8080/api/doctors/' + userId + '/patients/',
      headers: header);
  return parsePatients(response.body);
}

class PatientPage extends StatelessWidget {
  final List<Patient> patients;
  PatientPage({Key key, this.patients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacientes'),
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
          tooltip: 'Previous choice',
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            var pat = await getOldPatient();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage(pat)));
          },
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PatientAddPage()));
                },
                child: Icon(Icons.add),
              )),
        ],
      ),
      body: FutureBuilder<List<Patient>>(
        future: fetchPatients(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListViewPatients(patients: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Future<Patient> getOldPatient() async {
  Patient patient = await DataApi.getCurrentPatient();
  return patient;
}
