import 'package:flutter/material.dart';

Map<TextSize, double> sizeMap = {
  TextSize.large: 2,
  TextSize.medium: 1,
  TextSize.small: 0.8,
};

Map<TextFamily, String?> familyMap = {
  TextFamily.borel: 'Borel',
  TextFamily.dancingScript: 'DancingScript',
  TextFamily.handjet: 'Handjet',
  TextFamily.standard: null,
};

Map<ColorTheme, Color> colorMap = {
  ColorTheme.blue: Colors.blue,
  ColorTheme.green: Colors.green,
  ColorTheme.red: Colors.red,
  ColorTheme.purple: Colors.purple,
};

enum TextSize { small, medium, large }

enum TextFamily { borel, dancingScript, handjet, standard }

enum ColorTheme { blue, red, purple, green }
