import "dart:math";

import "package:flutter/material.dart";
import "package:muon/editor.dart";
import "package:muon/synaps_compat.dart";

class MuonProjectMetadataMenu extends StatelessWidget {
  const MuonProjectMetadataMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(height: 10),
        Align(
            alignment: Alignment.center,
            child: Text(
              "Project Settings",
              style: TextStyle(fontSize: 26),
            )),
        SizedBox(height: 10),
        Align(
            alignment: Alignment.center,
            child: Rx(() => Text(
                  "${currentProject.bpm} BPM",
                  style: TextStyle(fontSize: 16),
                ))),
        Rx(() => Slider(
              value: currentProject.bpm,
              min: 40,
              max: 240,
              divisions: 200,
              label: "${currentProject.bpm} bpm",
              onChanged: (double value) {
                currentProject.bpm = value.floorToDouble();
                currentProject.markAllVoicesAsChanged();
              },
            )),
        SizedBox(height: 10),
        Align(
            alignment: Alignment.center,
            child: Rx(() => Text(
                  "${currentProject.beatsPerMeasure} Beats per Measure",
                  style: TextStyle(fontSize: 16),
                ))),
        Rx(() => Slider(
              value: currentProject.beatsPerMeasure.toDouble(),
              min: 1,
              max: 32,
              divisions: 32,
              label: "${currentProject.beatsPerMeasure} beats",
              onChanged: (double value) {
                currentProject.beatsPerMeasure = value.round();
                currentProject.markAllVoicesAsChanged();
              },
            )),
        SizedBox(height: 10),
        Align(
            alignment: Alignment.center,
            child: Rx(() => Text(
                  "Beat Value of 1 / ${currentProject.beatValue}",
                  style: TextStyle(fontSize: 16),
                ))),
        Rx(() => Slider(
              value: log(currentProject.beatValue) / log(2),
              min: 1,
              max: 5,
              divisions: 4,
              label: "1 / ${currentProject.beatValue}",
              onChanged: (double value) {
                currentProject.beatValue = pow(2, value.round()).toInt();
                currentProject.markAllVoicesAsChanged();
              },
            )),
      ],
    ));
  }
}
