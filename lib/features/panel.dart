import 'package:dart_console/dart_console.dart';

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

    final PanelCornerStyle cornerStyle = title?.style ?? style;

    final PanelLineStyle line = title?.style == PanelCornerStyle.doubled
        ? PanelLineStyle.doubled
        : PanelLineStyle.single;

    final String ptl = cornerStyle._tl;
    final String ptr = cornerStyle._tr;
    final String pbl = cornerStyle._bl;
    final String pbr = cornerStyle._br;
    final String px = line._x;

    String vl = line._vl;
    String vr = line._vr;

    String x = line._x;
    String y = line._y;

    if (title?.style != PanelCornerStyle.doubled &&
        style == PanelCornerStyle.doubled) {
      vl = line._ovl;
      vr = line._ovr;

      x = PanelLineStyle.doubled._x;
      y = PanelLineStyle.doubled._y;
    }

    if (title?.style == PanelCornerStyle.doubled &&
        style != PanelCornerStyle.doubled) {
      vl = line._ovl;
      vr = line._ovr;

      x = PanelLineStyle.single._x;
      y = PanelLineStyle.single._y;
    }

    if (title != null) {
      console.writeLine(
        '  $ptl${px * (title!.text.length + 2)}$ptr',
      );

      console.writeLine(
        '${style._tl}$x$vl ${title!.text} $vr${x * (panelWidth - widthCompensation)}${style._tr}',
      );
      console.writeLine(
        '$y $pbl${px * titleLength}$pbr${" " * (panelWidth - widthCompensation)}$y',
      );
    }

    if (title == null) {
      console.writeLine(
        '${style._tl}${x * (width != null ? panelWidth - 2 : panelWidth + 2)}${style._tr}',
      );
    }

    final int lineLength = panelWidth - 4;
    final List<String> bodyText = [];
    if (text.length > lineLength) {
      RegExp rx = RegExp(
        ".{1,$lineLength}(?=(.{$lineLength})+(?!.))|.{1,$lineLength}\$",
      );
      bodyText.addAll(rx.allMatches(text).map((m) => m.group(0) ?? ''));
    } else {
      bodyText.add(text);
    }

    for (final String textLine in bodyText) {
      _writeBody(
        textLine,
        alignment,
        panelWidth,
        console,
        y,
      );
    }

    console.writeLine(
      '${style._bl}${x * ((panelWidth + 1) - (widthCompensation - 2) + (titleLength))}${style._br}',
    );
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
    String text,
    TextAlignment alignment,
    int? width,
    Console console,
    String y,
  ) {
    final int padding = ((width ?? 0 / 2) - (text.length + 4)).toInt();

    // Compensate for text that would push the right border to a new line
    // when the text is centered.
    int paddingCompensation = ((padding ~/ 2).isOdd) ? 1 : 0;
    if ((((padding ~/ 2) * 2) + paddingCompensation) + text.length + 4 >
        console.windowWidth) paddingCompensation = 0;

    console.write('$y ');
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
    console.write(' $y');
    console.write(console.newLine);
  }
}

class ChubbyPanelTitle {
  final String text;
  final PanelCornerStyle style;

  const ChubbyPanelTitle(this.text, {this.style = PanelCornerStyle.round});
}

enum PanelCornerStyle {
  doubled('╔', '╗', '╚', '╝'),
  round('╭', '╮', '╰', '╯'),
  square('┌', '┐', '└', '┘');

  final String _tl;
  final String _tr;
  final String _bl;
  final String _br;
  const PanelCornerStyle(this._tl, this._tr, this._bl, this._br);
}

enum PanelLineStyle {
  doubled('═', '║', '╣', '╢', '╠', '╟'),
  single('─', '│', '┤', '╡', '├', '╞');

  final String _x;
  final String _y;
  final String _vl;
  final String _vr;
  final String _ovl;
  final String _ovr;

  const PanelLineStyle(
    this._x,
    this._y,
    this._vl,
    this._ovl,
    this._vr,
    this._ovr,
  );
}
