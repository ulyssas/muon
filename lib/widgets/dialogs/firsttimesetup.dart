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
        title: Text("Hello and welcome!"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                  "Before you start using Muon, we need to do some housekeeping!"),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: Text("Choose NEUTRINO SDK Folder Location"),
                onPressed: () async {
                  try {
                    final String? selectedDir = await getDirectoryPath(
                      confirmButtonText: "Open NEUTRINO SDK",
                    );

                    if (selectedDir != null) {
                      final isNeutrino = File("$selectedDir/bin/NEUTRINO.exe").existsSync() || File("$selectedDir/bin/NEUTRINO").existsSync();
                      if (Directory(selectedDir).existsSync() && isNeutrino) {
                        settings.neutrinoDir = selectedDir;
                        settings.save();
                        return;
                      }

                      settings.neutrinoDir = "";
                      settings.save();

                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        content: Text(
                            "Error: That doesn't seem like a valid NEUTRINO directory!"),
                        duration: Duration(seconds: 5),
                      ));
                    }
                  } catch (err) {
                    print("internal file browser error: $err");
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              SwitchListTile(
                title: Text("Please burn my eyes"),
                secondary: Icon(Icons.lightbulb_outline),
                value: !appSettings.darkMode,
                onChanged: (value) {
                  appSettings.darkMode = !value;
                },
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("I'm all set!"),
            onPressed: () {
              if (settings.neutrinoDir == "") {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text(
                      "Error: Please choose a valid directory for the NEUTRINO library!"),
                  duration: Duration(seconds: 5),
                ));
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
