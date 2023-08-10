import 'package:flutter/material.dart';
import 'package:foyer_test/model/current_settings_provider.dart';
import 'package:foyer_test/model/location_model.dart';
import 'package:foyer_test/screens/create_profile.dart';
import 'package:foyer_test/utils/database_init.dart';
import 'package:foyer_test/utils/utils.dart';
import 'package:foyer_test/widgets/lat_long_input.dart';
import 'package:foyer_test/widgets/location_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> profileList = [];

  InfoModel? currentProfileModel;

  bool isLoading = true;

  void fetchProfiles() async {
    isLoading = true;
    setState(() {});
    profileList = await SqliteDB().retrieveAllValues();
    await fetchCurrentProfile();
    isLoading = false;
    setState(() {});
  }

  Future<void> fetchCurrentProfile() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? currentProfileId = prefs.getInt('currentProfileId');
    print("Current profile id: $currentProfileId");
    if (currentProfileId != null) {
      List<Map<String, dynamic>> result =
          await SqliteDB().retrieveValueBasedOnId(currentProfileId);
      if (result.isNotEmpty) {
        currentProfileModel = Utils().resultToInfoModel(result[0]);
        context
            .read<CurrentSettingsProvider>()
            .setColor(currentProfileModel!.deviceProfile.theme);
        context
            .read<CurrentSettingsProvider>()
            .setFamily(currentProfileModel!.deviceProfile.textFamily);
        context
            .read<CurrentSettingsProvider>()
            .setSize(currentProfileModel!.deviceProfile.textSize);
      }
    }
  }

  void _addNewLocation() async {
    Navigator.push(context, MaterialPageRoute(builder: (_) => CreateProfile()));
  }

  @override
  void initState() {
    super.initState();
    fetchProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Location Based Profiles'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: isLoading
                  ? [
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    ]
                  : profileList.isEmpty
                      ?
                      // First time setup
                      <Widget>[
                          const Text(
                              "Looks like you are creating the profile for the first time"),
                          const SizedBox(height: 10),
                          const LatLongInputFields()
                        ]
                      :
                      // Repeater setup
                      <Widget>[
                          const Text("Your current profile: "),
                          const SizedBox(height: 10),
                          LocationCard(
                            model: currentProfileModel,
                          ),
                          const Divider(),
                          const Text("Saved device profiles: "),
                          const SizedBox(height: 10),
                          ...profileList.map((e) {
                            InfoModel model = Utils().resultToInfoModel(e);
                            return GestureDetector(
                              onTap: () async {
                                currentProfileModel = model;
                                context
                                    .read<CurrentSettingsProvider>()
                                    .setSize(model.deviceProfile.textSize);
                                context
                                    .read<CurrentSettingsProvider>()
                                    .setFamily(model.deviceProfile.textFamily);
                                context
                                    .read<CurrentSettingsProvider>()
                                    .setColor(model.deviceProfile.theme);
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setInt('currentProfileId', model.id!);
                                setState(() {});
                              },
                              child: LocationCard(model: model),
                            );
                          }).toList()
                        ],
            ),
          ),
        ),
      ),
      floatingActionButton: profileList.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: _addNewLocation,
              child: const Icon(Icons.add_location_alt),
            ),
    );
  }
}
