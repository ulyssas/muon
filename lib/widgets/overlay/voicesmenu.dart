import "package:file_selector/file_selector.dart";
import "package:flutter/material.dart";
import "package:muon/controllers/muonvoice.dart";
import "package:muon/editor.dart";
import "package:muon/logic/musicxml.dart";
import "package:muon/synaps_compat.dart";
import "package:muon/widgets/overlay/voicecontrols.dart";

class MuonVoicesMenu extends StatelessWidget {
  const MuonVoicesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          Expanded(
            child: Scrollbar(
              child: Rx(
                () => ListView.builder(
                  itemCount: currentProject.voices.length,
                  itemBuilder: (context, index) {
                    final voice = currentProject.voices[index];
                    return MuonVoiceControls(voice: voice);
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: themeData.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 5),
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 3,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text("Voices", style: TextStyle(fontSize: 26)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Transform.translate(
                    offset: const Offset(-5, 0),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      tooltip: "Add voice",
                      onPressed: () {
                        final newVoice = MuonVoiceController().ctx();
                        currentProject.addVoice(newVoice);
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Transform.translate(
                    offset: const Offset(-35, 0),
                    child: IconButton(
                      icon: const Icon(Icons.code),
                      tooltip: "Import voice from MusicXML",
                      onPressed: () async {
                        try {
                          final XFile? file = await openFile(
                            confirmButtonText: "Open MusicXML File",
                          );

                          if (file != null) {
                            final MusicXML musicXML = MusicXMLUtils.parseFile(
                              file.path,
                            );
                            currentProject.importVoiceFromMusicXML(
                              musicXML,
                              true,
                            );
                          }
                        } catch (err) {
                          print("internal file browser error: $err");
                        }
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Transform.translate(
                    offset: const Offset(-65, 0),
                    child: IconButton(
                      icon: const Icon(Icons.queue_music),
                      tooltip: "Import voice from MIDI",
                      onPressed: () async {
                        try {
                          final XFile? file = await openFile(
                            confirmButtonText: "Open MIDI File",
                          );

                          if (file != null) {
                            currentProject.importVoiceFromMIDIFile(
                              file.path,
                              true,
                            );
                          }
                        } catch (err) {
                          print("internal file browser error: $err");
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
