import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 显示提示
showToast(msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIos: 1,
    backgroundColor: Color.fromRGBO(0, 0, 0, 0.25),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
