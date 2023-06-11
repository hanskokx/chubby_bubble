library chubby_bubble;

import 'package:chubby_bubble/features/panel.dart';
import 'package:dart_console/dart_console.dart';

export 'package:dart_console/dart_console.dart' show TextAlignment;

export 'features/panel.dart' show PanelCornerStyle, ChubbyPanelTitle;

class ChubbyBubble {
  static final Console _console = Console();
  const ChubbyBubble._();

  static void panel(
    String text, {
    PanelCornerStyle style = PanelCornerStyle.round,
    ChubbyPanelTitle? title,
    int? width,
    TextAlignment alignment = TextAlignment.left,
  }) {
    final int maxWidth = ((width != null) && (width <= _console.windowWidth))
        ? width
        : _console.windowWidth;

    ChubbyPanel(
      text,
      alignment: alignment,
      style: style,
      width: width != null ? maxWidth : null,
      title: title != null
          ? ChubbyPanelTitle(
              title.text,
              style: title.style,
            )
          : null,
    ).render(_console);
  }
}
