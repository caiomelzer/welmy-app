import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welmy/models/Network.dart';

class BalancaApi {
  static Future<bool> register(String ssid, String password) async {
    //AJUSTAR A URL ABAIXO TIAGO
    var url = 'http://192.168.4.1/app/reset';
    var header = {"Content-Type": "application/json"};
    try {
      if (ssid.length < 3) return false;
      if (password.length < 3) return false;
      Map params = {"AP": ssid, "Pass": password};
      var _body = json.encode(params);
      var response = await http.post(url, headers: header, body: _body);
      Map mapResponse = json.decode(response.body);
    } on Exception catch (e) {}
    return true;
  }

  static Future<dynamic> list() async {
    var header = {"Content-Type": "application/json"};
    var response =
        await http.get('http://192.168.4.1/find-networks', headers: header);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<bool> doMeasure(String mac) async {
    try {
      var url = 'http://welmy.iogas.com.br:8080/api/equipments/' +
          mac +
          '/measurements/';
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.get('token');
      var header = {
        "x-access-token": "$token",
        "Content-Type": "application/json"
      };
      var patientId = sharedPreferences.get('patientId');
      Map params = {"patientId": patientId};
      var _body = json.encode(params);
      var response = await http.post(url, headers: header, body: _body);
      Map mapResponse = json.decode(response.body);
    } on Exception catch (e) {}
    return Future.delayed(Duration(seconds: 0), () => true);
  }
}
