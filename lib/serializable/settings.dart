import "dart:convert";
import "dart:io";

import "package:json_annotation/json_annotation.dart";

part "settings.g.dart";

@JsonSerializable()
class MuonSettings {
  MuonSettings();

  bool darkMode = false;
  String neutrinoDir = "";

  factory MuonSettings.fromJson(Map<String, dynamic> json) =>
      _$MuonSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$MuonSettingsToJson(this);

  static MuonSettings? loadFromFile([
    String settingsFile = "muon_settings.json",
  ]) {
    if (File(settingsFile).existsSync()) {
      final file = File(settingsFile);

      if (file.existsSync()) {
        final fileContents = file.readAsStringSync();

        final jsonData = jsonDecode(fileContents);
        final MuonSettings settings = MuonSettings.fromJson(jsonData);

        return settings;
      }
    }

    return null;
  }

  void save([String settingsFile = "muon_settings.json"]) {
    final jsonContents = toJson();
    final String fileContents = jsonEncode(jsonContents);

    final file = File(settingsFile);
    file.writeAsStringSync(fileContents);
  }
}

MuonSettings getMuonSettings() {
  final settings = MuonSettings.loadFromFile();

  return settings ?? MuonSettings();
}
