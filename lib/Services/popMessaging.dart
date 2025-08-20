import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastInfo(String msg,
    {Color backgroundColor = Colors.blue, Color textColor = Colors.white}) {
  return Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      toastLength: Toast.LENGTH_LONG,
      textColor: textColor,
      backgroundColor: backgroundColor,
      fontSize: 16);
}
