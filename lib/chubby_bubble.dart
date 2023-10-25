library chubby_bubble;

import 'package:chubby_bubble/classes/panel_style.dart';
import 'package:chubby_bubble/classes/panel_title.dart';
import 'package:chubby_bubble/features/panel.dart';
import 'package:dart_console/dart_console.dart';

export 'package:dart_console/dart_console.dart' show TextAlignment;

export 'classes/corner_style.dart' show CornerStyle;
export 'classes/edge_style.dart' show EdgeStyle;
export 'classes/panel_style.dart' show ChubbyPanelStyle;
export 'classes/panel_title.dart' show ChubbyPanelTitle;
export 'common/ansi.dart' show AnsiCode, AnsiColor, AnsiReset, AnsiExtension;

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
