import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welmy/models/Measurement.dart';
class MeasureApi{
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    return token;
  }
 
  static Future<dynamic> list(String patient, String view) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.get('token');
    var header = {"x-access-token": "$token", "Content-Type" : "application/json"};
    print(view);
    if(view=='7 dias')
      view = 'last_7_days';
    if(view=='30 dias')
      view = 'last_30_days';  
    if(view=='Mes')
      view = 'month';  
    if(view=='Ano')
      view = 'year';  
    var response = await http.get('http://welmy.iogas.com.br:8080/api/patients/'+patient+'/measurements/'+view, headers: header);
    if (response.statusCode == 200) {
      print('response.body');
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}


