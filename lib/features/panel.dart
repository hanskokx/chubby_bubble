import 'dart:io';

import 'package:chubby_bubble/classes/edge_style.dart';
import 'package:chubby_bubble/classes/panel_style.dart';
import 'package:chubby_bubble/classes/panel_title.dart';
import 'package:chubby_bubble/common/ansi.dart';
import 'package:dart_console/dart_console.dart';

class ChubbyPanel {
  final ChubbyPanelStyle style;
  final ChubbyPanelTitle? title;
  final String text;
  final int? width;
  final TextAlignment alignment;
  final AnsiColor color;

  const ChubbyPanel(
    this.text, {
    this.style = const ChubbyPanelStyle(),
    this.title,
    this.width,
    this.alignment = TextAlignment.left,
    this.color = AnsiColor.brightWhite,
  });

  static final StringBuffer _buffer = StringBuffer();

  void _renderTitle(
    ChubbyPanelTitle title,
    int width,
    Console console,
  ) {
    String leftConnector = title.style.edgeStyle.vl;
    String rightConnector = title.style.edgeStyle.vr;

    if (style.edgeStyle != EdgeStyle.double &&
        title.style.edgeStyle == EdgeStyle.double) {
      leftConnector = title.style.edgeStyle.ovl;
      rightConnector = title.style.edgeStyle.ovr;
    }

    // Title's top border
    _buffer.write('  ');
    _buffer.write(title.style.cornerStyle.tl.color(title.style.borderColor));
    _buffer.write((title.style.edgeStyle.x * (title.text.length + 2))
        .color(title.style.borderColor));
    _buffer.write(title.style.cornerStyle.tr.color(title.style.borderColor));
    _buffer.writeln();

    // Title content
    _buffer.write(style.cornerStyle.tl.color(style.borderColor));
    _buffer.write(style.edgeStyle.x.color(style.borderColor));
    _buffer.write(leftConnector.color(title.style.borderColor));
    _buffer.write(' ');
    _buffer.write(title.text.color(title.style.textColor));
    _buffer.write(' ');
    _buffer.write(rightConnector.color(title.style.borderColor));
    _buffer.write((style.edgeStyle.x * (width - title.text.length - 7))
        .color(style.borderColor));
    _buffer.write(style.cornerStyle.tr.color(style.borderColor));
    _buffer.writeln();

    // Title's bottom border
    _buffer.write(style.edgeStyle.y.color(style.borderColor));
    _buffer.write(' ');
    _buffer.write(title.style.cornerStyle.bl.color(title.style.borderColor));
    _buffer.write((title.style.edgeStyle.x * (title.text.length + 2))
        .color(title.style.borderColor));
    _buffer.write(title.style.cornerStyle.br.color(title.style.borderColor));
    _buffer.write(' ' * (width - title.text.length - 7));
    _buffer.write(style.edgeStyle.y.color(style.borderColor));
    _buffer.writeln();
  }

  void render(Console console) {
    final int finalWidth =
        _calculatePanelWidth(width ?? stdout.terminalColumns, text);
    final int charactersPerLine = _calculateCharactersPerLine(finalWidth, text);
    final int numberOfLines =
        _calculateNumberOfLines(finalWidth, charactersPerLine, text);

    // final EdgeStyle lineStyle = title?.style.cornerStyle == CornerStyle.double
    //     ? EdgeStyle.double
    //     : EdgeStyle.single;

    // String x = lineStyle.x;
    // String y = lineStyle.y;

    // if (title?.style.cornerStyle != CornerStyle.double &&
    //     style.cornerStyle == CornerStyle.double) {
    //   x = EdgeStyle.double.x;
    //   y = EdgeStyle.double.y;
    // }

    // if (title?.style.cornerStyle == CornerStyle.double &&
    //     style.cornerStyle != CornerStyle.double) {
    //   x = EdgeStyle.single.x;
    //   y = EdgeStyle.single.y;
    // }

    if (title != null) {
      _renderTitle(title!, finalWidth, console);
    }

    if (title == null) {
      _buffer.write(style.cornerStyle.tl.color(style.borderColor));
      _buffer.write(
          (style.edgeStyle.x * (finalWidth - 2)).color(style.borderColor));
      _buffer.write(style.cornerStyle.tr.color(style.borderColor));
      _buffer.writeln();
    }

    final List<String> bodyText = [];
    if (numberOfLines > 1) {
      bodyText.addAll(_splitString(text, charactersPerLine));
    } else {
      bodyText.add(text);
    }

    for (final String textLine in bodyText) {
      _buffer.write('${style.edgeStyle.y} '.color(style.borderColor));
      _buffer.write(textLine
          .alignText(
            width: charactersPerLine,
            alignment: alignment,
          )
          .color(style.textColor));
      _buffer.write(' ${style.edgeStyle.y}'.color(style.borderColor));
      _buffer.writeln();
    }

    _buffer.write(style.cornerStyle.bl.color(style.borderColor));
    _buffer
        .write((style.edgeStyle.x * (finalWidth - 2)).color(style.borderColor));
    _buffer.write(style.cornerStyle.br.color(style.borderColor));
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
