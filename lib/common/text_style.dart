import 'package:chubby_bubble/common/ansi.dart';
import 'package:dart_console/dart_console.dart';

/// - `[TextAlign] alignment`: Aligns the text within the panel.
///
///   - `TextAlign.left` (default): Aligns the text to the left side
///   - `TextAlign.center`: Centers the text within the panel
///   - `TextAlign.right`: Aligns the text to the right side
class ChubbyTextStyle {
  final bool bold;
  final bool dim;
  final bool italic;
  final bool underline;
  final bool blinking;
  final bool inverse;
  final bool invisible;
  final bool strikethrough;

  final AnsiColor? color;
  final TextAlignment alignment;

  const ChubbyTextStyle({
    this.bold = false,
    this.dim = false,
    this.italic = false,
    this.underline = false,
    this.blinking = false,
    this.inverse = false,
    this.invisible = false,
    this.strikethrough = false,
    this.color,
    this.alignment = TextAlignment.left,
  });
}
