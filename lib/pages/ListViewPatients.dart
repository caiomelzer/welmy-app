import 'package:flutter/material.dart';
import 'package:welmy/models/patient.dart';
import 'package:welmy/pages/home.dart';
import 'package:welmy/services/data.dart';


class ListViewPatients extends StatelessWidget {
  final List<Patient> patients;

  ListViewPatients({Key key, this.patients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: patients.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    '${patients[position].id} - ${patients[position].fullname}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    '${patients[position].email}',
                    style: new TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  onTap: () => _onTapItem(context, patients[position]),
                ),
              ],
            );
          }),
    );
  }

  void _onTapItem(BuildContext context, Patient patient) {
    DataApi.setPatientFullname(patient.fullname);
    DataApi.setPatientId(patient.id.toString());
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(patient)));
  }
}
