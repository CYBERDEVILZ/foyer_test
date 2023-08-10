import 'package:flutter/material.dart';
import 'package:foyer_test/constants.dart';
import 'package:foyer_test/model/device_profile.dart';
import 'package:foyer_test/model/location_model.dart';
import 'package:foyer_test/screens/home_page.dart';
import 'package:foyer_test/utils/database_init.dart';

class ProfilePopUp extends StatefulWidget {
  const ProfilePopUp({super.key, required this.lat, required this.long});
  final String lat;
  final String long;

  @override
  State<ProfilePopUp> createState() => _ProfilePopUpState();
}

class _ProfilePopUpState extends State<ProfilePopUp> {
  TextSize textSize = TextSize.medium;
  TextFamily textFamily = TextFamily.standard;
  ColorTheme selectedColor = ColorTheme.purple;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              InfoModel model = InfoModel(
                lat: double.parse(widget.lat),
                long: double.parse(widget.long),
                deviceProfile: DeviceProfile(
                  textFamily: textFamily,
                  textSize: textSize,
                  theme: selectedColor,
                ),
              );
              await SqliteDB().insertLocationData(model);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => const HomePage()),
                  (route) => false);
            },
            child: const Text("Create Profile"),
          ),
        ],
        title: const Text("Add a device profile"),
        content: Column(
          children: [
            Text("Latitude: ${widget.lat}"),
            Text("Longitude: ${widget.long}"),
            const Divider(),
            const SizedBox(height: 10),
            const Text("Select Font Size:"),
            Wrap(
              children: [
                RadioMenuButton(
                  value: TextSize.small,
                  groupValue: textSize,
                  onChanged: (onChanged) {
                    textSize = onChanged!;
                    setState(() {});
                  },
                  child: const Text(
                    "Small",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                RadioMenuButton(
                  value: TextSize.medium,
                  groupValue: textSize,
                  onChanged: (onChanged) {
                    textSize = onChanged!;
                    setState(() {});
                  },
                  child: const Text(
                    "Medium",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                RadioMenuButton(
                  value: TextSize.large,
                  groupValue: textSize,
                  onChanged: (onChanged) {
                    textSize = onChanged!;
                    setState(() {});
                  },
                  child: const Text(
                    "Large",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const Divider(),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Select Font Family:"),
            Wrap(
              children: [
                RadioMenuButton(
                  value: TextFamily.standard,
                  groupValue: textFamily,
                  onChanged: (onChanged) {
                    textFamily = onChanged!;
                    setState(() {});
                  },
                  child: Text(
                    TextFamily.standard.name,
                    style: const TextStyle(
                      fontFamily: null,
                    ),
                  ),
                ),
                RadioMenuButton(
                  value: TextFamily.borel,
                  groupValue: textFamily,
                  onChanged: (onChanged) {
                    textFamily = onChanged!;
                    setState(() {});
                  },
                  child: Text(
                    TextFamily.borel.name,
                    style: TextStyle(
                      fontFamily: TextFamily.borel.name,
                    ),
                  ),
                ),
                RadioMenuButton(
                  value: TextFamily.dancingScript,
                  groupValue: textFamily,
                  onChanged: (onChanged) {
                    textFamily = onChanged!;
                    setState(() {});
                  },
                  child: Text(
                    TextFamily.dancingScript.name,
                    style: TextStyle(
                      fontFamily: TextFamily.dancingScript.name,
                    ),
                  ),
                ),
                RadioMenuButton(
                  value: TextFamily.handjet,
                  groupValue: textFamily,
                  onChanged: (onChanged) {
                    textFamily = onChanged!;
                    setState(() {});
                  },
                  child: Text(
                    TextFamily.handjet.name,
                    style: TextStyle(
                      fontFamily: TextFamily.handjet.name,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            const Text("Select Color Theme: "),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: ColorTheme.values
                  .map((e) => GestureDetector(
                        onTap: () {
                          selectedColor = e;
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          alignment: Alignment.center,
                          width: 40,
                          height: 40,
                          color: colorMap[e],
                          child: selectedColor == e
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
