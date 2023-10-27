import 'package:chubby_bubble/features/panel/classes/panel_style.dart';

class ChubbyPanelTitle {
  final String text;
  final ChubbyPanelStyle style;

  const ChubbyPanelTitle(
    this.text, {
    this.style = const ChubbyPanelStyle(),
  });
}
