import "dart:math";

import "package:muon/actions/base.dart";
import "package:muon/controllers/muonvoice.dart";

class RemoveVoiceAction extends MuonAction {
  @override
  String get title {
    return "Remove voice";
  }

  @override
  String get subtitle {
    return "";
  }

  final MuonVoiceController voice;

  RemoveVoiceAction(this.voice);

  @override
  void perform() {
    final currentID = voice.project.voices.indexOf(voice);
    if (voice.project.currentVoiceID >= currentID) {
      voice.project.currentVoiceID--;
      voice.project.currentVoiceID = max(0, voice.project.currentVoiceID);
    }
    if (voice.audioPlayer != null) {
      voice.audioPlayer!.dispose();
      voice.audioPlayer = null;
    }
    voice.project.voices.remove(voice);
  }

  @override
  void undo() {
    voice.project.addVoiceInternal(voice);
  }
}
