import "package:muon/actions/base.dart";
import "package:muon/controllers/muonnote.dart";

class CutNoteAction extends MuonAction {
  @override
  String get title {
    if (notes.length > 1) {
      return "Cut notes";
    } else {
      return "Cut note";
    }
  }

  @override
  String get subtitle {
    return "";
  }

  final List<MuonNoteController> notes;

  CutNoteAction(this.notes);

  @override
  void perform() {
    for (final note in notes) {
      note.voice.notes.remove(note);
    }
  }

  @override
  void undo() {
    for (final note in notes) {
      note.voice.addNoteInternal(note);
    }
  }

  @override
  void markVoiceModified() {
    for (final note in notes) {
      note.voice.hasChangedNoteData = true;
    }
  }
}
