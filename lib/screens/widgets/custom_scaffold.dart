import 'package:flutter/material.dart';

import 'custom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget bottomNavigationBar;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Color backgroundColor;

  const CustomScaffold({
    Key key,
    this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: backgroundColor,
        body: body,
        drawer: Drawer(),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}
