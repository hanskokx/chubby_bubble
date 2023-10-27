import 'package:chubby_bubble/common/ansi.dart';
import 'package:chubby_bubble/common/text_style.dart';
import 'package:chubby_bubble/features/panel/classes/corner_style.dart';
import 'package:chubby_bubble/features/panel/classes/edge_style.dart';

class ChubbyPanelStyle {
  final CornerStyle cornerStyle;
  final EdgeStyle edgeStyle;
  final AnsiColor? backgroundColor;
  final AnsiColor? borderColor;
  final ChubbyTextStyle? textStyle;

  const ChubbyPanelStyle({
    this.cornerStyle = CornerStyle.round,
    this.edgeStyle = EdgeStyle.single,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
  });
}
