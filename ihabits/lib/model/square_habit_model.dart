import 'package:flutter/material.dart';

class SquareHabitModel extends ChangeNotifier {
  int _completedPercent = 0;

  int get completedPercent => _completedPercent;

  void updateCompletedPercent(int percent) {
    _completedPercent = percent;
    notifyListeners();
  }
}
