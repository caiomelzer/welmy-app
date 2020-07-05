import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class DataApi{
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    return token;
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
  static Future<String> getPatientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientId = prefs.getString('patientId');
    return patientId;
  }
}