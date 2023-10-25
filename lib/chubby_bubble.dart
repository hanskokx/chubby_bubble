library chubby_bubble;

import 'package:chubby_bubble/features/panel/panel.dart';
import 'package:dart_console/dart_console.dart';

export 'package:dart_console/dart_console.dart' show TextAlignment;

export 'common/ansi.dart' show AnsiCode, AnsiColor, AnsiReset, AnsiExtension;
export 'features/panel/panel.dart'
    show
        ChubbyPanel,
        CornerStyle,
        EdgeStyle,
        ChubbyPanelStyle,
        ChubbyPanelTitle;

class ChubbyBubble {
  static final Console _console = Console();
  const ChubbyBubble._();

  static void panel(
    String text, {
    ChubbyPanelStyle style = const ChubbyPanelStyle(),
    ChubbyPanelTitle? title,
    int? width,
    TextAlignment alignment = TextAlignment.left,
  }) {
    ChubbyPanel(
      text,
      alignment: alignment,
      style: style,
      width: width,
      title: title != null
          ? ChubbyPanelTitle(
              title.text,
              style: title.style,
            )
          : null,
    ).render(_console);
  }
}
