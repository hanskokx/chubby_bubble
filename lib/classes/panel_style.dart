import 'package:chubby_bubble/classes/corner_style.dart';
import 'package:chubby_bubble/classes/edge_style.dart';
import 'package:chubby_bubble/common/ansi.dart';

class ChubbyPanelStyle {
  final CornerStyle cornerStyle;
  final EdgeStyle edgeStyle;
  final AnsiColor textColor;
  final AnsiColor borderColor;

  const ChubbyPanelStyle({
    this.cornerStyle = CornerStyle.round,
    this.edgeStyle = EdgeStyle.single,
    this.textColor = AnsiColor.brightWhite,
    this.borderColor = AnsiColor.brightWhite,
  });
}
