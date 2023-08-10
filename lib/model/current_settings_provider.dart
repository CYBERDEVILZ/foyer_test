import 'package:flutter/material.dart';
import 'package:foyer_test/constants.dart';

class CurrentSettingsProvider extends ChangeNotifier {
  final int _bodyText = 15;
  final int _titleText = 24;

  TextSize _size = TextSize.medium;
  TextFamily? _family = TextFamily.standard;
  ColorTheme _theme = ColorTheme.blue;

  double getBodyTextSize() => _bodyText * sizeMap[_size]!;
  double getTitleTextSize() => _titleText * sizeMap[_size]!;

  String? getTextFamily() => familyMap[_family];

  Color getTheme() => colorMap[_theme]!;

  void setSize(TextSize size) {
    _size = size;
    notifyListeners();
  }

  void setFamily(TextFamily family) {
    _family = family;
    notifyListeners();
  }

  void setColor(ColorTheme color) {
    _theme = color;
    notifyListeners();
  }
}
