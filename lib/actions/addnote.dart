import "package:muon/actions/base.dart";
import "package:muon/controllers/muonnote.dart";

class AddNoteAction extends MuonAction {
  @override
  String get title {
    return "Add note";
  }

  @override
  String get subtitle {
    return "";
  }

  final MuonNoteController note;

  AddNoteAction(this.note);

  @override
  void perform() {
    note.voice.addNoteInternal(note);
  }

  @override
  void undo() {
    note.voice.notes.remove(note);
  }

  @override
  void markVoiceModified() {
    note.voice.hasChangedNoteData = true;
  }
}
