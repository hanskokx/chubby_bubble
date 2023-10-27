import 'package:chubby_bubble/features/panel/classes/panel_style.dart';

abstract class ChubbyWidget {
  final String? text;
  const ChubbyWidget({this.text});
  void render(
    StringBuffer buffer,
    int width, {
    bool isChild,
    ChubbyPanelStyle parentTheme,
    int parentPadding,
  });
}
