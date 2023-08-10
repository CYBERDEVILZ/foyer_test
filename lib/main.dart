import 'package:flutter/material.dart';
import 'package:foyer_test/model/current_settings_provider.dart';
import 'package:foyer_test/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (create) => CurrentSettingsProvider(),
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Merlin Foyer Assignment',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: context.watch<CurrentSettingsProvider>().getTheme()),
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontFamily:
                    context.watch<CurrentSettingsProvider>().getTextFamily(),
                fontSize:
                    context.watch<CurrentSettingsProvider>().getBodyTextSize(),
              ),
              titleLarge: TextStyle(
                fontFamily:
                    context.watch<CurrentSettingsProvider>().getTextFamily(),
                fontSize:
                    context.watch<CurrentSettingsProvider>().getTitleTextSize(),
              ),
            ),
            useMaterial3: true,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
