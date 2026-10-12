import "package:muon/actions/base.dart";
import "package:muon/controllers/muonnote.dart";

class PasteNoteAction extends MuonAction {
  @override
  String get title {
    if (notes.length > 1) {
      return "Paste notes";
    } else {
      return "Paste note";
    }
  }

  @override
  String get subtitle {
    return "";
  }

  final List<MuonNoteController> notes;

  PasteNoteAction(this.notes);

  @override
  void perform() {
    for (final note in notes) {
      note.voice.addNoteInternal(note);
    }
  }

  @override
  void undo() {
    for (final note in notes) {
      note.voice.notes.remove(note);
    }
  }

  @override
  void markVoiceModified() {
    for (final note in notes) {
      note.voice.hasChangedNoteData = true;
    }
  }
}
