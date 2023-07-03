import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = 337.0,
  double height = 50,
  Color textColor = Colors.white,
  Color background = Colors.blue,
  required Function function,
  required String text,
}) =>
    GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Center(
            child: Text(
          text.toUpperCase(),
          style: TextStyle(
              fontFamily: 'ZenDots', fontSize: 16.0, color: textColor),
        )),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  Function(String)? onSubmit,
  Function(String)? onChange,
  VoidCallback? onTap,
  String? Function(String?)? validator,
  String? label,
  String? labelText,
  IconData? prefix,
  IconData? suffix,
  bool isPassword = false,
  bool enable = true,
  VoidCallback? suffixPressed,
  required TextInputType Type,
  Color? backgroundColor = Colors.white,

  //bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: Type,
      enabled: enable,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: validator,
      onTap: onTap,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor,
        hintText: label,
        labelText: labelText,
        prefixIcon: Icon(
          prefix,
          color: Colors.grey,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: const Icon(
                  Icons.remove_red_eye,
                  color: Colors.grey,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.red,
              width: 0,
              style: BorderStyle.none,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.red,
              width: 0,
              style: BorderStyle.none,
            )),
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
// ignore: constant_identifier_names
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

void navigateAndFinish(BuildContext context, Widget newScreen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (BuildContext context) => newScreen),
    (Route<dynamic> route) => false,
  );
}
