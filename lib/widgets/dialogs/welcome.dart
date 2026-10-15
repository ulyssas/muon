import "dart:io";

import "package:flutter/material.dart";
import "package:muon/editor.dart";

class MuonWelcomeDialog extends StatelessWidget {
  const MuonWelcomeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: const Center(child: Text("Welcome to Muon!")),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ElevatedButton(
                child: const Text("Create New Project"),
                onPressed: () async {
                  final suc = await MuonEditor.createNewProject();
                  if (suc == true) {
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text("Open Project"),
                onPressed: () async {
                  final suc = await MuonEditor.openProject(context);
                  if (suc == true) {
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("About"),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationVersion: "0.0.4",
                applicationName: "Muon",
                applicationLegalese: "copyright (c) swadical 2021",
              );
            },
          ),
          OutlinedButton(
            child: const Text("Quit"),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }
}
