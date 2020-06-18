import 'package:flutter/material.dart';
import 'package:welmy/pages/signin.dart';
import 'package:welmy/pages/signup.dart';
import 'package:welmy/pages/balanca.dart';
import 'package:welmy/pages/about.dart';
import 'package:welmy/pages/patient.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (context) => HomePage(),
        '/signin': (context) => SigninPage(),
        '/signup': (context) => SignupPage(),
        '/balanca': (context) => BalancaPage(),
        '/sobre': (context) => AboutPage(),
        '/pacientes': (context) => PatientPage(),
      },
      theme: ThemeData(primaryColor : Colors.blue),
      home: checkUserLoggedIn() == null
          ? HomePage()
          : SigninPage(),
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