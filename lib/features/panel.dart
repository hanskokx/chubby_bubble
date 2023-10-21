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

  void render(Console console) {
    final int titleLength = title != null ? title!.text.length + 2 : 0;
    final int panelWidth = _calculatePanelWidth(
      text,
      titleLength,
      width,
      console.windowWidth,
    );

    print("Panel width: $panelWidth, Console width: ${stdout.terminalColumns}");

    final int widthCompensation = width != null ? 5 : 1;

    final CornerStyle cornerStyle = title?.style ?? style;

    final LineStyle line = title?.style == CornerStyle.doubled
        ? LineStyle.doubled
        : LineStyle.single;

    final String ptl = cornerStyle.tl;
    final String ptr = cornerStyle.tr;
    final String pbl = cornerStyle.bl;
    final String pbr = cornerStyle.br;
    final String px = line.x;

    String vl = line.vl;
    String vr = line.vr;

    String x = line.x;
    String y = line.y;

    if (title?.style != CornerStyle.doubled && style == CornerStyle.doubled) {
      vl = line.ovl;
      vr = line.ovr;

      x = LineStyle.doubled.x;
      y = LineStyle.doubled.y;
    }

    if (title?.style == CornerStyle.doubled && style != CornerStyle.doubled) {
      vl = line.ovl;
      vr = line.ovr;

      x = LineStyle.single.x;
      y = LineStyle.single.y;
    }

    if (title != null) {
      console.writeLine(
        '  $ptl${px * (title!.text.length + 2)}$ptr',
      );

      console.writeLine(
        '${style.tl}$x$vl ${title!.text} $vr${x * (panelWidth - widthCompensation)}${style.tr}',
      );
      console.writeLine(
        '$y $pbl${px * titleLength}$pbr${" " * (panelWidth - widthCompensation)}$y',
      );
    }

    if (title == null) {
      console.writeLine(
        '${style.tl}${x * (width != null ? panelWidth - 2 : panelWidth + 2)}${style.tr}',
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
      '${style.bl}${x * ((panelWidth + 1) - (widthCompensation - 2) + (titleLength))}${style.br}',
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
