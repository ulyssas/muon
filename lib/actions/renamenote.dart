import "package:muon/actions/base.dart";
import "package:muon/controllers/muonnote.dart";

class RenameNoteAction extends MuonAction {
  @override
  String get title {
    if (newLyrics.length > 1) {
      return "Rename ${newLyrics.length} note lyrics";
    } else {
      return "Rename note lyric";
    }
  }

  @override
  String get subtitle {
    return "to $textInput";
  }

  final Map<MuonNoteController, String> newLyrics;
  final Map<MuonNoteController, String> oldLyrics;
  final String textInput;

  RenameNoteAction(this.newLyrics, this.oldLyrics, this.textInput);

  @override
  void perform() {
    for (final note in newLyrics.keys) {
      note.lyric = newLyrics[note];
    }
  }

  @override
  void undo() {
    for (final note in oldLyrics.keys) {
      note.lyric = oldLyrics[note];
    }
  }

  @override
  void markVoiceModified() {
    for (final note in newLyrics.keys) {
      note.voice.hasChangedNoteData = true;
    }
  }
}
