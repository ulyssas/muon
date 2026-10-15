import "package:flutter/material.dart";
import "package:muon/widgets/overlay/actionsmenu.dart";
import "package:muon/widgets/overlay/projectmetadatamenu.dart";
import "package:muon/widgets/overlay/voicesmenu.dart";

class MuonSidebar extends StatelessWidget {
  const MuonSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 7,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MuonProjectMetadataMenu(),
          const SizedBox(height: 10),
          const Expanded(child: MuonVoicesMenu()),
          SizedBox(height: 150, child: MuonActionsMenu()),
        ],
      ),
    );
  }
}
