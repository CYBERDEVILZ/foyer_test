import 'package:foyer_test/constants.dart';

class DeviceProfile {
  final TextSize textSize;
  final ColorTheme theme;
  final TextFamily textFamily;

  DeviceProfile({
    required this.textFamily,
    required this.textSize,
    required this.theme,
  });
}
