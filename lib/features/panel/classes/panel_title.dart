import 'package:chubby_bubble/features/panel/classes/panel_theme.dart';

class ChubbyPanelTitle {
  final String text;
  final ChubbyPanelTheme theme;

  const ChubbyPanelTitle(
    this.text, {
    this.theme = const ChubbyPanelTheme(),
  });
}
