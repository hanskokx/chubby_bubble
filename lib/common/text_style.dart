import 'package:chubby_bubble/common/ansi.dart';

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
  });
}
