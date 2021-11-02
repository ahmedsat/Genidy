import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(
          color: Colors.white,
          image: AssetImage('images/icons/pharmShop.png'),
        ),
        Positioned(
          top: 23,
          left: 22,
          child: Image(
            width: 50,
            // color: Colors.white,
            image: AssetImage('images/icons/g.png'),
          ),
        ),
      ],
    );
  }
}
