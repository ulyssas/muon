abstract class MuonAction {
  /// Human readable title of the action
  String get title;

  /// Human readable subtitle of the action
  String get subtitle;

  /// Perform the action
  void perform();

  /// Undo the action
  void undo();

  /// Mark a voice as modified
  void markVoiceModified() {}
}
