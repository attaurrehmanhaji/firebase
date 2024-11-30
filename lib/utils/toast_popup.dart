import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMsg {
  void toast(String message, Color bgColor, Color txtColor) {
    Fluttertoast.showToast(
        msg: message,
        // toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: bgColor,
        textColor: txtColor,
        fontSize: 19.sp);
  }
}
