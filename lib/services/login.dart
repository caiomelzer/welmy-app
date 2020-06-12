import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class LoginApi{
  static Future<bool> signin(String user, String password) async {
    try{
      var url ='http://ec2-18-228-166-214.sa-east-1.compute.amazonaws.com:8080/api/auth/signin';
      var header = {"Content-Type" : "application/json"};
      if(user.length < 3)
        return false;
      if(password.length < 3)
        return false;
      Map params = {
        "username" : user,
        "password" : password
      };
      var _body = json.encode(params);
      var response = await http.post(url, headers:header, body: _body);
      Map mapResponse = json.decode(response.body);
      if(mapResponse.containsKey('accessToken')){
        String token = mapResponse["accessToken"];
        String username = mapResponse["username"];
        String userId = mapResponse["id"].toString();
        String patientId = mapResponse["id"].toString();
        print(mapResponse);
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('token', token);
        sharedPreferences.setString('username', username);
        sharedPreferences.setString('userId', userId);
        sharedPreferences.setString('patientId', patientId);
        return true;
      }
      else{
        return false;
      }
    }on Exception catch (e) {
      print('Exception details:\n $e');
    }
  }
  static Future<bool> signup(String username, String password, String fullname, String email) async {
    try{
      var url ='http://ec2-18-228-166-214.sa-east-1.compute.amazonaws.com:8080/api/auth/signup';
      var header = {"Content-Type" : "application/json"};
      Map params = {
        "username" : username,
        "password" : password,
        "fullname" : fullname,
        "email" : email
      };
      var _body = json.encode(params);
      var response = await http.post(url, headers:header, body: _body);
      Map mapResponse = json.decode(response.body);
      String token = mapResponse["accessToken"];
      if(token.length < 1){
        String username = mapResponse["username"];
        String userId = mapResponse["id"].toString();
        String patientId = mapResponse["id"].toString();
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('token', token);
        sharedPreferences.setString('username', username);
        sharedPreferences.setString('userId', userId);
        sharedPreferences.setString('patientId', patientId);
        return true;
      }
      return false;
    }on Exception catch (e) {
      print('Exception details:\n $e');
    }
  }
}