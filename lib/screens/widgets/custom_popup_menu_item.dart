import 'package:flutter/material.dart';

class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;

  CustomPopupMenuItem({@required this.onClick, @required this.child}) : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return CustomPopupMenuItemState();
  }
}

class CustomPopupMenuItemState<T, PopupMenuItem> extends PopupMenuItemState<T, CustomPopupMenuItem<T>> {
  @protected
  void handleTap() {
    widget.onClick();
  }
}
