import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welmy/models/Network.dart';
class BalancaApi{
  static Future<bool> register(String ssid, String password) async {
    try{
      var url ='http://welmy.iogas.com.br:8080/api/auth/signin';
      var header = {"Content-Type" : "application/json"};
      if(ssid.length < 3)
        return false;
      if(password.length < 3)
        return false;
        //http://192.168.4.1/app/find-networks
      Map params = {
        "AP" : ssid,
        "Pass" : password
      };
      var _body = json.encode(params);
      var response = await http.get('http://welmy.iogas.com.br:8080/');
      Map mapResponse = json.decode(response.body);
      print(mapResponse);
      return true;
      
    }on Exception catch (e) {
      print('Exception details:\n $e');
    }
  }
  static Future<dynamic> list() async {
    var header = {
      "Content-Type": "application/json"
    };
    var response = await http.get('http://192.168.4.1/find-networks', headers: header);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}