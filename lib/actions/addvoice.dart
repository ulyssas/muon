import "dart:math";

import "package:muon/actions/base.dart";
import "package:muon/controllers/muonvoice.dart";

class AddVoiceAction extends MuonAction {
  @override
  String get title {
    return "Add voice";
  }

  @override
  String get subtitle {
    return "";
  }

  final MuonVoiceController voice;

  AddVoiceAction(this.voice);

  @override
  void perform() {
    voice.project.addVoiceInternal(voice);
  }

  @override
  void undo() {
    final currentID = voice.project.voices.indexOf(voice);
    if (voice.project.currentVoiceID >= currentID) {
      voice.project.currentVoiceID--;
      voice.project.currentVoiceID = max(0, voice.project.currentVoiceID);
    }
    if (voice.audioPlayer != null) {
      voice.audioPlayer.dispose();
      voice.audioPlayer = null;
    }
    voice.project.voices.remove(voice);
  }
}
