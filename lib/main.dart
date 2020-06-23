import 'package:flutter/material.dart';
import 'package:welmy/pages/signin.dart';
import 'package:welmy/pages/signup.dart';
import 'package:welmy/pages/balanca.dart';
import 'package:welmy/pages/about.dart';
import 'package:welmy/pages/PatientPage.dart';
import 'package:welmy/models/Patient.dart';

import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welmy/pages/home.dart';

void main() {runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState  extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    var userData = getUserData();
    print(userData);
    
    print(checkUserLoggedIn());
    print('aq');
    var page = checkUserLoggedIn() == null
          ? HomePage(null)
          : SigninPage();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (context) => HomePage(null),
        '/signin': (context) => SigninPage(),
        '/signup': (context) => SignupPage(),
        '/balanca': (context) => BalancaPage(),
        '/sobre': (context) => AboutPage(),
        '/pacientes': (context) => PatientPage(),
      },
      theme: ThemeData(primaryColor : Colors.blue),
      home: page,
    );
  }
}

Future<bool> checkUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  print(token); 
  if(token != null){
    return true;
  }
  else {
    return false;
  } 
}

Future<Patient> getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var patient = new Patient();
  patient.fullname = prefs.getString('username');
  patient.id = int.parse(prefs.getString('userId'));
  return patient;
}