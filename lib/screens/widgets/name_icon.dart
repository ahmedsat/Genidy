import 'package:flutter/material.dart';

import '../../constants.dart';

class NameIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        // text: 'Hello ',
        style: DefaultTextStyle.of(context).style,
        children: const <TextSpan>[
          TextSpan(
            text: 'gen',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: KGoldColor,
            ),
          ),
          TextSpan(text: 'idy'),
        ],
      ),
    );
  }
}
