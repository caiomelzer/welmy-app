import 'dart:async';
import 'package:welmy/pages/signin.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welmy/utils/sidebar.dart';
import '../services/balanca.dart';
import 'package:welmy/models/patient.dart';



class HomePage extends StatefulWidget {
  Patient patient;
  HomePage([this.patient]);
  @override
  _HomePageState createState() => _HomePageState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  String barcode = "";
  String viewSelected = "Semana";
  //String userSelected = widget.;
  final List<String> items = <String>['Dia','Semana','Mes'];

  @override
  initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    print(_HomePageState);
    



    var data = [
      ClicksPerYear('Dom', 10, Colors.lightBlue),
      ClicksPerYear('Seg', 11, Colors.lightBlue),
      ClicksPerYear('Ter', 12, Colors.lightBlue),
      ClicksPerYear('Qua', 12, Colors.lightBlue),
      ClicksPerYear('Qui', 12, Colors.lightBlue),
      ClicksPerYear('Sex', 13, Colors.lightBlue),
      ClicksPerYear('Sab', 12, Colors.lightBlue),
    ];
    var series = [
      charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Gramas',
        data: data,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
          labelStyle: new charts.TextStyleSpec(
            fontSize: 10, // size in Pts.
            color: charts.MaterialPalette.white
          ),
          lineStyle: new charts.LineStyleSpec(
            color: charts.MaterialPalette.white
          ),
        ),
      ),
      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.GridlineRendererSpec(
          labelStyle: new charts.TextStyleSpec(
            fontSize: 12, // size in Pts.
            color: charts.MaterialPalette.white
          ),
          lineStyle: new charts.LineStyleSpec(
            color: charts.MaterialPalette.white
          ),
        ),
      ),       
    );


    var chartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(
        height: 200.0,
        child: chart,
      ),
    );
    
    return Scaffold(
      drawer: Sidebar(),
      backgroundColor: Colors.blueGrey[900],
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                color: Colors.grey[350],
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset('assets/images/logo.png', height: 25,), 
                        ), 
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            iconSize: 40,
                            color: Colors.black38,
                            icon: Icon(Icons.view_headline),
                            tooltip: '',
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          )
                        ), 
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey[350],
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              icon: Image.asset('assets/images/qrcode-trans.png'),
                              iconSize: 60,
                              onPressed: scan, 
                            ),
                        ), 
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  text: '3,815',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 65, color: Colors.black54, letterSpacing: -5),
                                  children: <TextSpan>[
                                    TextSpan(text: 'kg', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -3, fontSize: 45, color: Colors.lightBlueAccent), ),
                                  ]
                                ),
                              ),
                            ],
                          ),
                        ), 
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: new MaterialButton( 
                          height: 70.0, 
                          minWidth:250.0, 
                          color: Colors.lightBlue, 
                          textColor: Colors.white, 
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Align(
                                  child: Text(widget.patient.fullname,style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 16),),
                                  alignment: Alignment.topLeft,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  child: Icon(Icons.unfold_more),
                                  alignment: Alignment.topRight,
                                ),
                              )
                            ],
                          ), 
                          onPressed: () => {
                            changeUser(context)
                          }, 
                          splashColor: Colors.lightBlueAccent,
                        ),
                      ), 
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        height: 70,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[500],
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text('Período',style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                            value: viewSelected,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 32,
                            iconEnabledColor: Colors.white,
                            underline: SizedBox(),
                            onChanged: (String newValue) {
                              changeView(newValue);
                              setState(() {
                                viewSelected = newValue;
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return items.map<Widget>((String item) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child: Text(item,style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey[100]),)
                                );
                              }).toList();
                            },
                            items: items.map((String item) {
                              return DropdownMenuItem<String>(
                                child: Text(item,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                                value: item,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.blueGrey[900],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      chartWidget,
                    ],
                  ),
                ),
              )
            ],
          );
        }
      )
    );
  }

  

  changeUser(BuildContext context){
    Navigator.popAndPushNamed( 
      context,
      '/pacientes'
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      print(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          //this.barcode = 'The user did not grant the camera permission!';
          this.barcode = 'ecfabc5ee4c0';
          print('chamou teste');
          BalancaApi.doMeasure('ecfabc5ee4c0').then((v) => {
            print(v),
            print('resultado teste')
          });
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  String changeView(String selectedView){
    print(selectedView);
    return selectedView;
  }
}