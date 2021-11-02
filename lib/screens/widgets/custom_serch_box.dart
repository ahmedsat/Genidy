import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomSerchBox extends StatefulWidget implements PreferredSizeWidget {
  CustomSerchBox({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomSerchBoxState createState() => _CustomSerchBoxState();
}

class _CustomSerchBoxState extends State<CustomSerchBox> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
        ),
        child: TextFormField(
          cursorColor: KGoldColor,
          decoration: InputDecoration(
            hintText: 'تحت التطوير',
            prefixIcon: Padding(
              padding: EdgeInsets.all(0.0),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ), // icon is 48px widget.
            ),
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
      ),
    );
  }
}
