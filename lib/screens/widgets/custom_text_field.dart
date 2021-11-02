import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final Function onClick;
  final String initialValue;

  const CustomTextField({
    Key key,
    this.hintText,
    this.initialValue = '',
    this.onClick,
    this.icon = const Icon(
      Icons.description,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'القيمة فارغة برجاء الادخال';
          }
          return null;
        },
        onSaved: onClick,
        obscureText: hintText == 'ادخل كلمة المرور' ? true : false,
        initialValue: initialValue,
        cursorColor: KGoldColor,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: this.icon,
          filled: true,
          fillColor: Colors.lightBlue[300],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.blueGrey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
