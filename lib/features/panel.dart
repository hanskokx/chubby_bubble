import 'dart:io';

import 'package:chubby_bubble/classes/panel_title.dart';
import 'package:chubby_bubble/classes/style.dart';
import 'package:dart_console/dart_console.dart';

class ChubbyPanel {
  final CornerStyle style;
  final ChubbyPanelTitle? title;
  final String text;
  final int? width;
  final TextAlignment alignment;

  const ChubbyPanel(
    this.text, {
    this.style = CornerStyle.round,
    this.title,
    this.width,
    this.alignment = TextAlignment.left,
  });

  void _renderTitle(
    ChubbyPanelTitle title,
    LineStyle lineStyle,
    CornerStyle cornerStyle,
    int width,
    Console console,
  ) {
    final int titleLength = title.text.length + 2;

    final String ptl = title.style.tl;
    final String ptr = title.style.tr;
    final String pbl = title.style.bl;
    final String pbr = title.style.br;

    final LineStyle lineStyle = title.style == CornerStyle.doubled
        ? LineStyle.doubled
        : LineStyle.single;

    final String px = lineStyle.x;

    String vl = lineStyle.vl;
    String vr = lineStyle.vr;

    String x = lineStyle.x;
    String y = lineStyle.y;

    if (title.style != CornerStyle.doubled &&
        cornerStyle == CornerStyle.doubled) {
      vl = lineStyle.ovl;
      vr = lineStyle.ovr;

      x = LineStyle.doubled.x;
      y = LineStyle.doubled.y;
    }

    if (title.style == CornerStyle.doubled &&
        cornerStyle != CornerStyle.doubled) {
      vl = lineStyle.ovl;
      vr = lineStyle.ovr;

      x = LineStyle.single.x;
      y = LineStyle.single.y;
    }

    final int widthMinusTitlePanel = width - title.text.length - 7;

    console.writeLine(
      '  $ptl${px * (title.text.length + 2)}$ptr',
    );

    console.writeLine(
      '${style.tl}$x$vl ${title.text} $vr${x * widthMinusTitlePanel}${style.tr}',
    );
    console.writeLine(
      '$y $pbl${px * titleLength}$pbr${" " * widthMinusTitlePanel}$y',
    );
  }

  void render(Console console) {
    final int finalWidth = _calculatePanelWidth(
        width ?? stdout.terminalColumns, text, title?.text);
    final int charactersPerLine = _calculateCharactersPerLine(finalWidth, text);
    final int numberOfLines =
        _calculateNumberOfLines(finalWidth, charactersPerLine, text);

    final LineStyle lineStyle = title?.style == CornerStyle.doubled
        ? LineStyle.doubled
        : LineStyle.single;

    String x = lineStyle.x;
    String y = lineStyle.y;

    if (title?.style != CornerStyle.doubled && style == CornerStyle.doubled) {
      x = LineStyle.doubled.x;
      y = LineStyle.doubled.y;
    }

    if (title?.style == CornerStyle.doubled && style != CornerStyle.doubled) {
      x = LineStyle.single.x;
      y = LineStyle.single.y;
    }

    if (title != null) {
      // print("Rendering title with width $finalWidth.");
      _renderTitle(title!, lineStyle, style, finalWidth, console);
    }

    if (title == null) {
      console.writeLine(
        '${style.tl}${x * (finalWidth - 2)}${style.tr}',
      );
    }

    final List<String> bodyText = [];
    if (numberOfLines > 1) {
      RegExp rx = RegExp(
        ".{1,$charactersPerLine}(?=(.{$charactersPerLine})+(?!.))|.{1,$charactersPerLine}\$",
      );
      bodyText.addAll(rx.allMatches(text).map((m) => m.group(0) ?? ''));
    } else {
      bodyText.add(text);
    }

    for (final String textLine in bodyText) {
      _writeBody(
        textLine,
        alignment,
        charactersPerLine,
        finalWidth,
        console,
        y,
      );
    }

    console.writeLine(
      '${style.bl}${x * (finalWidth - 2)}${style.br}',
    );
  }

  int _calculateNumberOfLines(int width, int charactersPerLine, String text) {
    int numLines = (text.length / width).ceil();

    // if this will fit inside the panel, we should return it instead of dividing it.
    if ((text.length % width).ceil() > width) {
      numLines = 1;
    }

    return numLines;
  }

  int _calculatePanelWidth(
    int width,
    String text,
    String? title,
  ) {
    // final int consoleWidth = stdout.terminalColumns;

    // int textLength = text.length;

    // final int numLines = _calculateNumberOfLines(width, text, title);

    // if (numLines > 1) {
    //   final int charactersPerLine = (text.length / numLines).round();
    //   textLength = charactersPerLine + 4;
    // }

    // final int titleLength = title != null ? title.length + 4 : 0;

    // if (titleLength > textLength) textLength = titleLength;

    // int panelWidth = consoleWidth;

    // if (width == null && textLength <= consoleWidth) {
    //   panelWidth = stdout.terminalColumns - 4;
    // }

    // if (width != null && panelWidth > textLength) panelWidth = textLength;

    // print("_calculatePanelWidth: Returning $panelWidth");
    // return panelWidth;

    final int consoleWidthIncludingPanel = stdout.terminalColumns - 4;

    int calculatedWidth = consoleWidthIncludingPanel;

    calculatedWidth = width;
    if (consoleWidthIncludingPanel < width) {
      calculatedWidth = consoleWidthIncludingPanel;
    }

    return calculatedWidth;
  }

  void _writeBody(
    String text,
    TextAlignment alignment,
    int textWidth,
    int consoleWidth,
    Console console,
    String y,
  ) {
    final int padding = ((consoleWidth - text.length) - 4).ceil();

    console.write('$y ');

    switch (alignment) {
      case TextAlignment.left:
        console.write(text);
        console.write(' ' * padding);
        break;
      case TextAlignment.center:
        final int leftPadding = (padding / 2).ceil();
        final int rightPadding = consoleWidth - text.length - leftPadding - 4;
        console.write(' ' * leftPadding);
        console.write(text);
        console.write(' ' * rightPadding);
        break;
      case TextAlignment.right:
        console.write(' ' * padding);
        console.write(text);
        break;
    }

    console.write(' $y');
    console.write(console.newLine);
  }

  int _calculateCharactersPerLine(int width, String text) {
    int charactersPerLine = width - 4;

    if (charactersPerLine > stdout.terminalColumns + 4) {
      charactersPerLine = stdout.terminalColumns - 4;
    }

    return charactersPerLine;
  }
}
