import 'package:chubby_bubble/features/panel.dart';
import 'package:dart_console2/dart_console2.dart';

main(List<String> arguments) {
  final Console console = Console();

  // ChubbyPanel with title
  ChubbyPanel(
    'Left align panel with rounded corners and a title with rounded corners',
    alignment: TextAlignment.left,
    style: PanelCornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: PanelCornerStyle.round,
    ),
  ).render(console);

  ChubbyPanel(
    'Center align panel with rounded corners and a title with rounded corners',
    alignment: TextAlignment.center,
    style: PanelCornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: PanelCornerStyle.round,
    ),
  ).render(console);

  ChubbyPanel(
    'Right align panel with rounded corners and a title with rounded corners',
    alignment: TextAlignment.right,
    style: PanelCornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: PanelCornerStyle.round,
    ),
  ).render(console);

  // ChubbyPanel with no title
  ChubbyPanel(
    'Left align panel with rounded corners and no title',
    alignment: TextAlignment.left,
    style: PanelCornerStyle.round,
  ).render(console);

  ChubbyPanel(
    'Center align panel with rounded corners and no title',
    alignment: TextAlignment.center,
    style: PanelCornerStyle.round,
  ).render(console);

  ChubbyPanel(
    'Right align panel with rounded corners and no title',
    alignment: TextAlignment.right,
    style: PanelCornerStyle.round,
  ).render(console);

  // ChubbyPanel with title and max width
  ChubbyPanel(
    'Left align panel with rounded corners and a title with rounded corners at maximum width',
    alignment: TextAlignment.left,
    width: console.windowWidth,
    style: PanelCornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: PanelCornerStyle.round,
    ),
  ).render(console);

  ChubbyPanel(
    'Center align panel with rounded corners and a title with rounded corners at maximum width',
    alignment: TextAlignment.center,
    width: console.windowWidth,
    style: PanelCornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: PanelCornerStyle.round,
    ),
  ).render(console);

  ChubbyPanel(
    'Right align panel with rounded corners and a title with rounded corners at maximum width',
    alignment: TextAlignment.right,
    width: console.windowWidth,
    style: PanelCornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: PanelCornerStyle.round,
    ),
  ).render(console);

  // ChubbyPanel with no title and max width
  ChubbyPanel(
    'Left align panel with rounded corners and no title',
    width: console.windowWidth,
    alignment: TextAlignment.left,
    style: PanelCornerStyle.round,
  ).render(console);

  ChubbyPanel(
    'Center align panel with rounded corners and no title',
    width: console.windowWidth,
    alignment: TextAlignment.center,
    style: PanelCornerStyle.round,
  ).render(console);

  ChubbyPanel(
    'Right align panel with rounded corners and no title',
    width: console.windowWidth,
    alignment: TextAlignment.right,
    style: PanelCornerStyle.round,
  ).render(console);

  return 0;
}
