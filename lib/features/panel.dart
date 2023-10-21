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
    final int panelWidth = _calculatePanelWidth(width, text, title?.text);

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
      _renderTitle(title!, lineStyle, style, panelWidth, console);
    }

    if (title == null) {
      console.writeLine(
        '${style.tl}${x * (panelWidth - 2)}${style.tr}',
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
      '${style.bl}${x * (panelWidth - 2)}${style.br}',
    );
  }

  int _calculateNumberOfLines(int? width, String text, String? title) {
    final int consoleWidth = stdout.terminalColumns;
    int calculatedWidth = consoleWidth;

    if (width != null && consoleWidth > width) calculatedWidth = width;

    final int numLines = (text.length / (calculatedWidth - 4)).ceil();

    return numLines;
  }

  int _calculatePanelWidth(int? width, String text, String? title) {
    final int consoleWidth = stdout.terminalColumns;

    int textLength = text.length + 4;

    final int numLines = _calculateNumberOfLines(width, text, title);

    if (numLines > 1) {
      final int charactersPerLine = (text.length / numLines).round();
      print("Characters per line: $charactersPerLine");
      textLength = charactersPerLine + 4;
    }

    final int titleLength = title != null ? title.length + 4 : 0;

    if (titleLength > textLength) textLength = titleLength;

    print(
      'Given Width: $width \nConsole Width: $consoleWidth \nActual Text Length: ${text.length} \nCalculated Text length: $textLength \nNumber of text lines: $numLines \n',
    );

    int panelWidth = consoleWidth;

    if (width == null) {
      print("No width specified. Using text width.");
      if (textLength <= consoleWidth) panelWidth = textLength;
    }

    if (width != null && panelWidth > textLength) {
      print("Width $width given; doing our best.");
      return textLength;
    }

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
