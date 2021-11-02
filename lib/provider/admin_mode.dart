// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminMode extends ChangeNotifier {
  bool isAdmin = false;
  setIsAdmin(bool b) {
    isAdmin = b;
    notifyListeners();
  }
}
