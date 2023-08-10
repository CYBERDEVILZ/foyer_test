import 'package:flutter/material.dart';
import 'package:foyer_test/constants.dart';
import 'package:foyer_test/model/location_model.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key, required this.model});

  final InfoModel? model;

  @override
  Widget build(BuildContext context) {
    TextStyle? bodyMedium = Theme.of(context).textTheme.bodyMedium;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      width: double.maxFinite,
      height: model == null ? 150 : null,
      decoration: BoxDecoration(
        color: model == null
            ? Colors.grey
            : colorMap[model!.deviceProfile.theme]!.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: model == null
            ? [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
                const Text(
                  "Click to create a new profile or select from saved profiles",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )
              ]
            : [
                Text(
                  "Profile ID: ${model!.id}",
                ),
                const SizedBox(height: 10),
                Text("Lat: ${model!.lat}"),
                Text("Long: ${model!.long}"),
                const SizedBox(height: 10),
                const Text("Device Profile:"),
                RichText(
                  text: TextSpan(
                    text: "FontFamily: ",
                    style: bodyMedium!,
                    children: <TextSpan>[
                      TextSpan(
                        text: "${model!.deviceProfile.textFamily.name}  |  ",
                        style: TextStyle(
                          fontFamily:
                              familyMap[model!.deviceProfile.textFamily],
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "FontSize: ${model!.deviceProfile.textSize.name}",
                        style: bodyMedium,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Theme: "),
                    Container(
                      width: 12,
                      height: 12,
                      color: colorMap[model!.deviceProfile.theme],
                    )
                  ],
                )
              ],
      ),
    );
  }
}
