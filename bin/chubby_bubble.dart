import 'package:chubby_bubble/features/panel.dart';
import 'package:dart_console2/dart_console2.dart';

main(List<String> arguments) {
  final Console console = Console();

  Panel(
    'Hello world!',
    width: 800,
    style: PanelEdgeStyle.square,
    title: PanelTitle(
      "Hey.",
      style: PanelEdgeStyle.round,
    ),
  ).render(console);

  return 0;
}
