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

  static final StringBuffer _buffer = StringBuffer();

  void _renderTitle(
    ChubbyPanelTitle title,
    LineStyle lineStyle,
    CornerStyle cornerStyle,
    int width,
    Console console,
  ) {
    final LineStyle lineStyle = title.style == CornerStyle.doubled
        ? LineStyle.doubled
        : LineStyle.single;

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

    // Title's top border
    _buffer.write('  ');
    _buffer.write(title.style.tl);
    _buffer.write(lineStyle.x * (title.text.length + 2));
    _buffer.write(title.style.tr);
    _buffer.writeln();

    // Title content
    _buffer.write(style.tl);
    _buffer.write(x);
    _buffer.write(vl);
    _buffer.write(' ');
    _buffer.write(title.text);
    _buffer.write(' ');
    _buffer.write(vr);
    _buffer.write(x * (width - title.text.length - 7));
    _buffer.write(style.tr);
    _buffer.writeln();

    // Title's bottom border
    _buffer.write(y);
    _buffer.write(' ');
    _buffer.write(title.style.bl);
    _buffer.write(lineStyle.x * (title.text.length + 2));
    _buffer.write(title.style.br);
    _buffer.write(' ' * (width - title.text.length - 7));
    _buffer.write(y);
    _buffer.writeln();
  }

  void render(Console console) {
    final int finalWidth =
        _calculatePanelWidth(width ?? stdout.terminalColumns, text);
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
      _renderTitle(title!, lineStyle, style, finalWidth, console);
    }

    if (title == null) {
      _buffer.write(style.tl);
      _buffer.write(x * (finalWidth - 2));
      _buffer.write(style.tr);
      _buffer.writeln();
    }

    final List<String> bodyText = [];
    if (numberOfLines > 1) {
      bodyText.addAll(_splitString(text, charactersPerLine));
    } else {
      bodyText.add(text);
    }

    for (final String textLine in bodyText) {
      _buffer.write('$y ');
      _buffer.write(textLine.alignText(
        width: charactersPerLine,
        alignment: alignment,
      ));
      _buffer.write(' $y');
      _buffer.writeln();
    }

    _buffer.write(style.bl);
    _buffer.write(x * (finalWidth - 2));
    _buffer.write(style.br);
    _buffer.writeln();

    console.write(_buffer.toString());
    _buffer.clear();
  }

  int _calculateNumberOfLines(int width, int charactersPerLine, String text) {
    if ((text.length % width).ceil() > width) return 1;
    return (text.length / width).ceil();
  }

  int _calculatePanelWidth(int width, String text) {
    final int consoleWidthIncludingPanel = stdout.terminalColumns - 4;

    int calculatedWidth = consoleWidthIncludingPanel;

    calculatedWidth = width;
    if (consoleWidthIncludingPanel < width) {
      calculatedWidth = consoleWidthIncludingPanel;
    }

    return calculatedWidth;
  }

  int _calculateCharactersPerLine(int width, String text) {
    int charactersPerLine = width - 4;

    if (charactersPerLine > stdout.terminalColumns + 4) {
      charactersPerLine = stdout.terminalColumns - 4;
    }

    return charactersPerLine;
  }

  List<String> _splitString(String text, int charactersPerLine) {
    List<String> result = [];
    for (int i = 0; i < text.length; i += charactersPerLine) {
      int end = (i + charactersPerLine < text.length)
          ? i + charactersPerLine
          : text.length;
      result.add(text.substring(i, end).trim());
    }
    return result;
  }
}
