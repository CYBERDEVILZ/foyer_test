import 'package:flutter/material.dart';
import 'package:foyer_test/utils/database_init.dart';
import 'package:foyer_test/utils/utils.dart';
import 'package:foyer_test/widgets/profile_pop_up.dart';

class LatLongInputFields extends StatefulWidget {
  const LatLongInputFields({super.key});

  @override
  State<LatLongInputFields> createState() => _LatLongInputFieldsState();
}

class _LatLongInputFieldsState extends State<LatLongInputFields> {
  late TextEditingController latController;
  late TextEditingController longController;

  bool validateLocation(String lat, String long) {
    try {
      double latDouble = double.parse(lat);
      double longDouble = double.parse(long);
      if (latDouble > 90 || latDouble < -90) {
        Utils().showSnackBar(context, "Invalid Latitude value");
        return false;
      }
      if (longDouble > 180 || longDouble < -180) {
        Utils().showSnackBar(context, "Invalid Longitude value");
        return false;
      }
      return true;
    } on FormatException {
      Utils().showSnackBar(context, "Invalid Input Type");
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    latController = TextEditingController();
    longController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    latController.dispose();
    longController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: latController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Latitude"),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: longController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Longitude"),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
            onPressed: () async {
              if (!validateLocation(
                latController.text,
                longController.text,
              )) {
                return;
              }
              List<Map<String, dynamic>> result =
                  await SqliteDB().valuesBasedOnLatAndLong(
                double.parse(latController.text),
                double.parse(longController.text),
              );
              if (result.isNotEmpty) {
                Utils().showSnackBar(context, "Location already exists");
                return;
              }
              await showDialog(
                context: context,
                builder: (buildContext) => ProfilePopUp(
                  lat: latController.text,
                  long: longController.text,
                ),
              );
            },
            child: const Text("Add Profile"),
          ),
        )
      ],
    );
  }
}
