import 'package:chubby_bubble/chubby_bubble.dart';

main(List<String> arguments) {
  // Panel with title
  ChubbyBubble.panel(
    'Left align panel with rounded corners and a title with rounded corners',
    alignment: TextAlignment.left,
    style: PanelCornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: PanelCornerStyle.round,
    ),
  );

  ChubbyBubble.panel(
    'Center align panel with rounded corners and a title with rounded corners',
    alignment: TextAlignment.center,
    style: PanelCornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: PanelCornerStyle.round,
    ),
  );

  ChubbyBubble.panel(
    'Right align panel with rounded corners and a title with rounded corners',
    alignment: TextAlignment.right,
    style: PanelCornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: PanelCornerStyle.round,
    ),
  );

  // ChubbyPanel with no title
  ChubbyBubble.panel(
    'Left align panel with rounded corners and no title',
    alignment: TextAlignment.left,
    style: PanelCornerStyle.round,
  );

  ChubbyBubble.panel(
    'Center align panel with rounded corners and no title',
    alignment: TextAlignment.center,
    style: PanelCornerStyle.round,
  );

  ChubbyBubble.panel(
    'Right align panel with rounded corners and no title',
    alignment: TextAlignment.right,
    style: PanelCornerStyle.round,
  );

  // ChubbyPanel with title and max width
  ChubbyBubble.panel(
    'Left align panel with rounded corners and a title with rounded corners at maximum width',
    alignment: TextAlignment.left,
    width: 1000,
    style: PanelCornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: PanelCornerStyle.round,
    ),
  );

  ChubbyBubble.panel(
    'Center align panel with rounded corners and a title with rounded corners at maximum width',
    alignment: TextAlignment.center,
    width: 1000,
    style: PanelCornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: PanelCornerStyle.round,
    ),
  );

  ChubbyBubble.panel(
    'Right align panel with rounded corners and a title with rounded corners at maximum width',
    alignment: TextAlignment.right,
    width: 1000,
    style: PanelCornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: PanelCornerStyle.round,
    ),
  );

  // ChubbyPanel with no title and max width
  ChubbyBubble.panel(
    'Left align panel with rounded corners and no title',
    width: 1000,
    alignment: TextAlignment.left,
    style: PanelCornerStyle.round,
  );

  ChubbyBubble.panel(
    'Center align panel with rounded corners and no title',
    width: 1000,
    alignment: TextAlignment.center,
    style: PanelCornerStyle.round,
  );

  ChubbyBubble.panel(
    'Right align panel with rounded corners and no title',
    width: 1000,
    alignment: TextAlignment.right,
    style: PanelCornerStyle.round,
  );

  return 0;
}
