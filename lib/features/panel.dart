import 'package:dart_console2/dart_console2.dart';

const String _x = '─';
const String _y = '│';

class ChubbyPanel {
  final PanelCornerStyle style;
  final ChubbyPanelTitle? title;
  final String text;
  final int? width;
  final TextAlignment alignment;

  const ChubbyPanel(
    this.text, {
    this.style = PanelCornerStyle.round,
    this.title,
    this.width,
    this.alignment = TextAlignment.left,
  });

  void render(Console console) {
    final int titleLength = title != null ? title!.text.length + 2 : 0;
    final int panelWidth = _calculatePanelWidth(text, titleLength, width);
    final int widthCompensation = width != null ? 5 : 1;

    if (title != null) {
      final String ptl = title?.style._tl ?? style._tl;
      final String ptr = title?.style._tr ?? style._tr;
      final String pbl = title?.style._bl ?? style._bl;
      final String pbr = title?.style._br ?? style._br;

      console.writeLine('  $ptl${_x * (title!.text.length + 2)}$ptr');
      console.writeLine(
          '${style._tl}$_x┤ ${title!.text} ├${_x * (panelWidth - widthCompensation)}${style._tr}');
      console.writeLine(
          '$_y $pbl${_x * titleLength}$pbr${" " * (panelWidth - widthCompensation)}$_y');
    }

    if (title == null) {
      console.writeLine(
          '${style._tl}${_x * (width != null ? panelWidth - 2 : panelWidth + 2)}${style._tr}');
    }

    _writeBody(text, alignment, width, console);
    console.writeLine(
        '${style._bl}${'─' * ((panelWidth + 1) - (widthCompensation - 2) + (titleLength))}${style._br}');
  }

  int _calculatePanelWidth(
    String text,
    int titleLength,
    int? width,
  ) {
    final int textLength = text.length;

    if (width == null) return textLength - titleLength;
    if (width > textLength) return width - titleLength;
    if (width < textLength) return width - titleLength;
    return textLength + titleLength;
  }

  void _writeBody(
      String text, TextAlignment alignment, int? width, Console console) {
    final int padding = ((width ?? 0 / 2) - (text.length + 4)).toInt();

    // Compensate for text that would push the right border to a new line
    // when the text is centered.
    int paddingCompensation = ((padding ~/ 2).isOdd) ? 1 : 0;
    if ((((padding ~/ 2) * 2) + paddingCompensation) + text.length + 4 >
        console.windowWidth) paddingCompensation = 0;

    console.write('$_y ');
    if (alignment == TextAlignment.right) {
      console.write(' ' * padding);
    }
    if (alignment == TextAlignment.center) console.write(' ' * (padding ~/ 2));
    console.write(text);
    if (alignment == TextAlignment.center) {
      console.write(' ' * ((padding ~/ 2) + paddingCompensation));
    }
    if (alignment == TextAlignment.left) {
      console.write(' ' * padding);
    }
    console.write(' $_y');
    console.write(console.newLine);
  }
}

class ChubbyPanelTitle {
  final String text;
  final PanelCornerStyle style;

  const ChubbyPanelTitle(this.text, {this.style = PanelCornerStyle.round});
}

enum PanelCornerStyle {
  round('╭', '╮', '╰', '╯'),
  square('┌', '┐', '└', '┘');

  final String _tl;
  final String _tr;
  final String _bl;
  final String _br;
  const PanelCornerStyle(this._tl, this._tr, this._bl, this._br);
}
