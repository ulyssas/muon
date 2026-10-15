import "dart:io";

import "package:flutter/material.dart";
import "package:muon/controllers/settings.dart";
import "package:muon/editor.dart";
import "package:muon/licenses.dart";
import "package:muon/synaps_compat.dart";
import "package:window_manager/window_manager.dart";

/// Main app settings
final appSettings = MuonSettingsController().ctx();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    windowManager.setTitle("Muon Editor");
    windowManager.setSize(const Size(1280, 720));
    windowManager.setMinimumSize(const Size(1280, 720));
    windowManager.center();
  }

  addLicenses();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Rx(() => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Muon",
          themeMode: appSettings.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.purple,
            brightness: Brightness.dark,
          ),
          home: MuonEditor(),
        ));
  }
}
