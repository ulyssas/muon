import "dart:io";

import "package:muon/serializable/settings.dart";
import "package:path/path.dart" as p;

class MuonHelpers {
  /// Returns a the absolute path to subdirectory `programName`
  /// inside the NEUTRINO directory
  static String getRawProgramPath(String subDir) {
    return "${getMuonSettings().neutrinoDir}/$subDir";
  }

  /// Returns a the absolute path to subdirectory `programName`
  /// inside the NEUTRINO `bin` directory
  static String getProgramPath(String programName) {
    String out = "${getMuonSettings().neutrinoDir}/bin/$programName";

    if (Platform.isWindows) {
      out += ".exe";
    }

    return out;
  }

  /// Returns a list of all available voice models
  /// (each entry is the name of the voice model folder)
  static List<String> getAllVoiceModels() {
    if (getMuonSettings().neutrinoDir == "") {
      return [];
    }
    final List<String> items = [];

    final modelsDir = Directory(getRawProgramPath("model"));
    final modelsDirFiles = modelsDir.listSync();

    for (final modelsDirFile in modelsDirFiles) {
      if (modelsDirFile is Directory) {
        final modelName = p.relative(modelsDirFile.path, from: modelsDir.path);
        items.add(modelName);
      }
    }

    items.sort();

    return items;
  }

  /// Returns the default voice model, which defaults to the
  /// (alphabetically) first entry in getAllVoiceModels();
  static String getDefaultVoiceModel() {
    final models = getAllVoiceModels();
    if (models.isEmpty) {
      return "";
    }
    return models[0];
  }
}
