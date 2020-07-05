import 'dart:async';
import 'package:welmy/models/Measurement.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:welmy/utils/sidebar.dart';
import '../services/balanca.dart';
import '../services/measures.dart';
import 'package:welmy/models/patient.dart';
import 'package:welmy/utils/alert.dart';
import 'package:welmy/services/data.dart';


class HomePage extends StatefulWidget {
  Patient patient;
  HomePage([this.patient]);
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  List data2 = List(); //edited line
  List<Measurement> measures = [];

  String barcode = "";
  String viewSelected = "Mes";
  //String userSelected = widget.;
  final List<String> items = <String>['7 dias','30 dias','Mes','Ano'];

  @override
  initState() {
    super.initState();
    getChartData2(viewSelected); 

  }

  @override
  Widget build(BuildContext context) {
    
    var series = [
      new charts.Series<Measurement, String>(
        domainFn: (Measurement clickData, _) => clickData.computedAt,
        measureFn: (Measurement clickData, _) => clickData.weight,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        id: 'Gramas',
        data: measures
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
                                  text: '0,000',
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

  Future<String> getChartData2(selectedView) async {
    var patientId = await DataApi.getPatientId();
    var response =  await MeasureApi.list(patientId,selectedView);
    setState(() {
      data2 = response;
      measures = data2.map((item) => Measurement(item['id'],item['fullname'],double.parse(item['weight']),item['x'])).toList();
    });
    return measures.toString();
  }

 
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode;
        BalancaApi.doMeasure(this.barcode).then((v) => {
          Alert.showAlertDialog(context, 'Vamos lá!', 'Favor efetuar a medição em até 30 segundos. Caso não efetue, a leitura será desconsiderada.','alert')
        });
      }); 
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          //this.barcode = 'The user did not grant the camera permission!';
          this.barcode = 'ecfabc5ee4c0';
          BalancaApi.doMeasure(this.barcode).then((v) => {
            Alert.showAlertDialog(context, 'Vamos lá!', 'Você ja pode efetuar a medição','alert')
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
    getChartData2(selectedView);
    return selectedView;
  }
} 