import 'dart:convert';

import 'package:foyer_test/model/device_profile.dart';

class InfoModel {
  final int? id;

  /// stores latitude
  final double lat;

  /// stores longitude
  final double long;

  /// stores device profile information
  final DeviceProfile deviceProfile;

  InfoModel({
    this.id,
    required this.lat,
    required this.long,
    required this.deviceProfile,
  });

  Map<String, dynamic> toMap() {
    return {
      "lat": lat,
      "long": long,
      "profile": jsonEncode({
        'size': deviceProfile.textSize.name,
        'color': deviceProfile.theme.name,
        'family': deviceProfile.textFamily.name,
      })
    };
  }
}
