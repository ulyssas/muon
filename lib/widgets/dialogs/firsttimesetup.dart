import "dart:io";

import "package:file_selector/file_selector.dart";
import "package:flutter/material.dart";
import "package:muon/editor.dart";
import "package:muon/main.dart";
import "package:muon/serializable/settings.dart";

class MuonFirstTimeSetupDialog extends StatelessWidget {
  const MuonFirstTimeSetupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = getMuonSettings();

    return Scaffold(
      body: AlertDialog(
        title: const Text("Hello and welcome!"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text(
                "Before you start using Muon, we need to do some housekeeping!",
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                child: const Text("Choose NEUTRINO SDK Folder Location"),
                onPressed: () async {
                  try {
                    final String? selectedDir = await getDirectoryPath(
                      confirmButtonText: "Open NEUTRINO SDK",
                    );

                    if (selectedDir != null) {
                      final isNeutrino =
                          File("$selectedDir/bin/NEUTRINO.exe").existsSync() ||
                          File("$selectedDir/bin/NEUTRINO").existsSync();
                      if (Directory(selectedDir).existsSync() && isNeutrino) {
                        settings.neutrinoDir = selectedDir;
                        settings.save();
                        return;
                      }

                      settings.neutrinoDir = "";
                      settings.save();

                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          content: const Text(
                            "Error: That doesn't seem like a valid NEUTRINO directory!",
                          ),
                          duration: const Duration(seconds: 5),
                        ),
                      );
                    }
                  } catch (err) {
                    print("internal file browser error: $err");
                  }
                },
              ),
              const SizedBox(height: 15),
              SwitchListTile(
                title: const Text("Please burn my eyes"),
                secondary: const Icon(Icons.lightbulb_outline),
                value: !appSettings.darkMode,
                onChanged: (value) {
                  appSettings.darkMode = !value;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("I'm all set!"),
            onPressed: () {
              if (settings.neutrinoDir == "") {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    content: const Text(
                      "Error: Please choose a valid directory for the NEUTRINO library!",
                    ),
                    duration: const Duration(seconds: 5),
                  ),
                );
              } else {
                Navigator.of(context, rootNavigator: true).pop();
                MuonEditor.showWelcomeScreen(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
