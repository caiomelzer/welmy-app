import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:welmy/models/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataApi {
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    return token;
  }

  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    return userId;
  }

  static Future<String> getPatientFullname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientFullname = prefs.getString('patientFullname');
    return patientFullname;
  }

  static void setPatientFullname(String patientFullname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('patientFullname', patientFullname);
  }

  static void setPatientId(String patientId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('patientId', patientId);
  }

  static Future<String> getPatientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientId = prefs.getString('patientId');
    return patientId;
  }

  static Future<Patient> getCurrentPatient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientId = prefs.getString('patientId');
    String fullname = prefs.getString('patientFullname');
    var patient = new Patient();
    patient.fullname = fullname;
    patient.id = int.parse(patientId);
    return patient;
  }
}
