import 'package:flutter/material.dart';
class Alert{
  static showAlertDialog(BuildContext context, String title, String description, String alertType) {
    String btnOk = 'Ok';
    //if(alertType == 'alert')

    // set up the button
    Widget okButton = FlatButton(
      child: Text(btnOk),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}