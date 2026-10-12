import "package:muon/actions/base.dart";
import "package:muon/controllers/muonvoice.dart";

class ChangeVoiceAction extends MuonAction {
  @override
  String get title {
    return "Change voice";
  }

  @override
  String get subtitle {
    return "to $newVoiceModel";
  }

  final MuonVoiceController voice;
  final String newVoiceModel;
  final String oldVoiceModel;

  ChangeVoiceAction(this.voice, this.newVoiceModel, this.oldVoiceModel);

  @override
  void perform() {
    voice.modelName = newVoiceModel;
  }

  @override
  void undo() {
    voice.modelName = oldVoiceModel;
  }

  @override
  void markVoiceModified() {
    voice.hasChangedNoteData = true;
  }
}
