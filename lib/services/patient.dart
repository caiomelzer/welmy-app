import 'dart:convert';
import 'package:http/http.dart' as http;
class PatientApi{
  static Future<dynamic> list(int userId) async {
    var url ='http://welmy.iogas.com.br:8080/api/doctors/1/patients/';
    var header = {
      "Content-Type": "application/json"
    };
    var response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  
  }
}