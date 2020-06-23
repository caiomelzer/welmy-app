import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:welmy/models/patient.dart';
import 'package:welmy/pages/ListViewPatients.dart';
import 'package:welmy/services/data.dart';
import 'package:welmy/pages/home.dart';

List<Patient> parsePatients(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Patient>((json) => Patient.fromJson(json)).toList();
}
Future<List<Patient>> fetchPatients(http.Client client) async {
  var token = await DataApi.getToken();
  var header = {"x-access-token": "$token", "Content-Type" : "application/json"};
  final response = await client.get('http://welmy.iogas.com.br:8080/api/doctors/1/patients/', headers: header);
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
                leading: new Container(),

        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            //child: GestureDetector(
              // onTap: () {
              //   var patient = new Patient();
              //   patient.fullname = getOldPatient() as String;
              //   print(patient.fullname);
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(patient)));
              // },
              // child: Icon(
              //   Icons.close
              // ),
            //)
          ),
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
Future<String> getOldPatient() async {
  String fullname = await DataApi.getPatientFullname();
  return fullname;
}