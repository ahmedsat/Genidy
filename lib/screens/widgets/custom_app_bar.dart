import 'package:flutter/material.dart';

import '../../constants.dart';
import '../cart_screen.dart';
import '../home_page.dart';
import 'name_icon.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight + 0),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: KGoldColor,
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                CartScreen.id,
              ),
            ),
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: KGoldColor,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Center(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                HomePage.id,
              ),
              child: NameIcon(),
            ),
          ),
          // bottom: CustomSerchBox(),
        ),
      ),
    );
  }
}
