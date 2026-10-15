import "dart:math";

import "package:flutter/material.dart";
import "package:muon/pianoroll/pianoroll.dart";

class PianoRollWAILAModule extends PianoRollModule {
  PianoRollWAILAModule() : super();

  @override
  bool hitTest(Point point) {
    return false;
  }

  @override
  void onHover(PointerEvent mouseEvent) {}

  @override
  void onClick(PointerEvent mouseEvent, int numClicks) {}

  @override
  void onDragStart(PointerEvent mouseEvent, Point mouseStartPos) {}

  @override
  void onDragging(PointerEvent mouseEvent, Point mouseStartPos) {}

  @override
  void onDragEnd(PointerEvent mouseEvent, Point mouseStartPos) {}

  @override
  void onSelect(PointerEvent mouseEvent, Rect selectionBox) {}

  @override
  void onKey(RawKeyEvent keyEvent) {}

  @override
  void paint(Canvas canvas, Size size) {
    if (state.curMousePos == null) return;

    final curMousePos = state.curMousePos;
    final themeData = painter.themeData;

    // clear all transforms
    canvas.restore();

    final mouseBeatNum = max(0, painter.getBeatNumAtCursor(curMousePos.x.toDouble()));
    final mouseBeatSubDivNum =
        (((mouseBeatNum * project.timeUnitsPerBeat).floor() %
                    project.timeUnitsPerBeat) ~/
                project.timeUnitsPerSubdivision) +
            1;
    final mouseMeasureNum = (mouseBeatNum / project.beatsPerMeasure).ceil();
    final mousePitch = painter.getPitchAtCursor(curMousePos.y.toDouble());
    var wailaLabelPainter = TextPainter(
      text: TextSpan(
        style: TextStyle(
          color: themeData.brightness == Brightness.light
              ? Colors.grey[600]
              : Colors.grey[200],
          fontSize: 24,
        ),
        text:
            "${mousePitch.note}${mousePitch.octave} | $mouseMeasureNum.${mouseBeatNum.ceil()}.$mouseBeatSubDivNum",
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    var wailaRect = Rect.fromLTWH(
      size.width - 10 - wailaLabelPainter.width,
      size.height - 10 - wailaLabelPainter.height,
      10 + wailaLabelPainter.width,
      10 + wailaLabelPainter.height,
    );
    var wailaShadowPath = Path();
    wailaShadowPath.addRect(wailaRect);

    canvas.drawShadow(wailaShadowPath, Colors.black, 10, false);
    canvas.drawRect(
        wailaRect, Paint()..color = themeData.scaffoldBackgroundColor);
    wailaLabelPainter.paint(
        canvas, Offset(wailaRect.left + 5, wailaRect.top + 5));

    // back up transforms
    canvas.save();

    // restore transforms
    painter.noteCoordinateSystem(canvas);
  }
}
