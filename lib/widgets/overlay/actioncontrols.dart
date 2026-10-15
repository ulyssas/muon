import "package:flutter/material.dart";
import "package:muon/actions/base.dart";
import "package:muon/editor.dart";

class MuonActionControls extends StatelessWidget {
  const MuonActionControls({
    super.key,
    required this.action,
    required this.isPerformed,
  });

  final MuonAction action;
  final bool isPerformed;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: isPerformed
            ? themeData.cardColor.withValues(alpha: 0.9)
            : themeData.cardColor.withValues(alpha: 0.3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 325,
              child: Text(
                "${action.title} ${action.subtitle}",
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  color: themeData.brightness == Brightness.dark
                      ? Colors.grey[100]
                      : Colors.grey[950],
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            icon: isPerformed ? const Icon(Icons.undo) : const Icon(Icons.redo),
            tooltip: isPerformed ? "Undo" : "Redo",
            onPressed: () {
              if (isPerformed) {
                currentProject.undoUntilAction(action);
              } else {
                currentProject.redoUntilAction(action);
              }
            },
          ),
        ],
      ),
    );
  }
}
