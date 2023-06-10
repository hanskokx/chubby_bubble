import 'package:chubby_bubble/features/panel.dart';

void main(List<String> arguments) {
  Panel(
    'Hello world!',
    width: 80,
    style: PanelEdgeStyle.square,
    title: PanelTitle(
      "Hey.",
      style: PanelEdgeStyle.round,
    ),
  ).render();
}
