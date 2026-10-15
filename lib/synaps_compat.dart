import "package:flutter/widgets.dart";

class Controller { const Controller(); }
class Observable { const Observable(); }
mixin WeakEqualityController {}
extension SynapsContextExtension<T> on T { T ctx() => this; }
typedef SynapsMap<K, V> = Map<K, V>;

class SynapsHub extends ChangeNotifier {
  static final SynapsHub instance = SynapsHub();
  static void notify() => instance.notifyListeners();
}

class Rx extends StatelessWidget {
  final Widget Function() builder;
  const Rx(this.builder, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: SynapsHub.instance,
      builder: (context, _) => builder(),
    );
  }
}

class RxCustomPaint extends StatelessWidget {
  final CustomPainter? painter;
  final Widget? child;
  const RxCustomPaint({super.key, this.painter, this.child, bool? willChange});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: SynapsHub.instance,
      builder: (context, _) => CustomPaint(painter: painter, child: child),
    );
  }
}