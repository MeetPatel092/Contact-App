import 'package:contact_hub/model/contact.dart';
import 'package:flutter/material.dart';

class StepperProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void incrementStep() {
    if (_count < 2) {
      _count++;
      notifyListeners();
    }
  }

  void decrementStep() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }

  void resetStep() {
    _count = 0;
    notifyListeners();
  }
}
