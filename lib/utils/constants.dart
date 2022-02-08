import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const kAppTitle = TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold);
const kButtonTitle =
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800, color: Colors.white);
const kBlueNavTextButton = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.blueAccent);
const kCheckPassSymbolizing =
    TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold);
const kCheckPassDetail = TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic);
const kResetPassTitle = TextStyle(
    fontSize: 20.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);

hideKeyboard(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());

DateTime? currentBackPressTime;

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(msg: "Press back again to exit");
    return Future.value(false);
  }
  return Future.value(true);
}
