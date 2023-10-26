import 'package:chubby_bubble/common/ansi.dart';
import 'package:chubby_bubble/features/panel/classes/corner_style.dart';
import 'package:chubby_bubble/features/panel/classes/edge_style.dart';

class ChubbyPanelStyle {
  final CornerStyle cornerStyle;
  final EdgeStyle edgeStyle;
  final AnsiColor textColor;
  final AnsiColor backgroundColor;
  final AnsiColor borderColor;

  const ChubbyPanelStyle({
    this.cornerStyle = CornerStyle.round,
    this.edgeStyle = EdgeStyle.single,
    this.textColor = AnsiColor.brightWhite,
    this.backgroundColor = AnsiColor.black,
    this.borderColor = AnsiColor.brightWhite,
  });
}
