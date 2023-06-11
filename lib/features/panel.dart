import 'package:dart_console/dart_console.dart';

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
    final int panelWidth = _calculatePanelWidth(
      text,
      titleLength,
      width,
      console.windowWidth,
    );

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

    final int lineLength = panelWidth - 4;
    final List<String> bodyText = [];
    if (text.length > lineLength) {
      RegExp rx = RegExp(
          ".{1,$lineLength}(?=(.{$lineLength})+(?!.))|.{1,$lineLength}\$");
      bodyText.addAll(rx.allMatches(text).map((m) => m.group(0) ?? ''));
    } else {
      bodyText.add(text);
    }

    for (final String line in bodyText) {
      _writeBody(line, alignment, panelWidth, console);
    }
    console.writeLine(
        '${style._bl}${'─' * ((panelWidth + 1) - (widthCompensation - 2) + (titleLength))}${style._br}');
  }

  int _calculatePanelWidth(
    String text,
    int titleLength,
    int? width,
    int consoleWidth,
  ) {
    final int textLength = text.length;
    int panelWidth = textLength + titleLength;

    if (width == null) panelWidth = textLength - titleLength;
    if (width != null && width > textLength) panelWidth = width - titleLength;
    if (width != null && width < textLength) panelWidth = width - titleLength;
    if (panelWidth > consoleWidth) panelWidth = consoleWidth;

    return panelWidth;
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
