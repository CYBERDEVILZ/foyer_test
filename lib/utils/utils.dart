import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foyer_test/constants.dart';
import 'package:foyer_test/model/device_profile.dart';
import 'package:foyer_test/model/location_model.dart';

class Utils {
  static final Utils _instance = Utils._internal();

  factory Utils() {
    return _instance;
  }

  Utils._internal();

  /// function to convert sql result to InfoModel
  InfoModel resultToInfoModel(Map<String, dynamic> map) {
    int id = map["id"];
    String profile = map["profile"];
    Map<String, dynamic> profileMap = json.decode(profile);

    // for family: default standard
    TextFamily family;
    String familyString = profileMap["family"];
    if (familyString == TextFamily.borel.name) {
      family = TextFamily.borel;
    } else if (familyString == TextFamily.dancingScript.name) {
      family = TextFamily.dancingScript;
    } else if (familyString == TextFamily.handjet.name) {
      family = TextFamily.handjet;
    } else {
      family = TextFamily.standard;
    }

    // for size: default medium
    TextSize size;
    String sizeString = profileMap["size"];
    if (sizeString == TextSize.small.name) {
      size = TextSize.small;
    } else if (sizeString == TextSize.large.name) {
      size = TextSize.large;
    } else {
      size = TextSize.medium;
    }

    // for color: default purple
    ColorTheme color;
    String colorString = profileMap["color"];
    if (colorString == ColorTheme.blue.name) {
      color = ColorTheme.blue;
    } else if (colorString == ColorTheme.green.name) {
      color = ColorTheme.green;
    } else if (colorString == ColorTheme.red.name) {
      color = ColorTheme.red;
    } else {
      color = ColorTheme.purple;
    }

    return InfoModel(
      id: id,
      lat: double.parse(map["lat"]),
      long: double.parse(map["long"]),
      deviceProfile: DeviceProfile(
        textFamily: family,
        textSize: size,
        theme: color,
      ),
    );
  }

  /// Function to show snack bar
  void showSnackBar(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
