import 'package:chubby_bubble/classes/style.dart';
import 'package:chubby_bubble/common/ansi.dart';

class ChubbyPanelTitle {
  final String text;
  final CornerStyle style;
  final AnsiColor color;

  const ChubbyPanelTitle(
    this.text, {
    this.style = CornerStyle.round,
    this.color = AnsiColor.brightWhite,
  });
}
