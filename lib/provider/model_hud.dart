import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier {
  bool isLoading = false;

  setLoading(bool b) {
    isLoading = b;
    notifyListeners();
  }
}
