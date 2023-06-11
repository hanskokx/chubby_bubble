import 'package:dart_console2/dart_console2.dart';

const String x = '─';
const String y = '│';

class Panel {
  final PanelEdgeStyle style;
  final PanelTitle? title;
  final String text;
  final int? width;
  final TextAlignment alignment;

  const Panel(
    this.text, {
    this.style = PanelEdgeStyle.round,
    this.title,
    this.width,
    this.alignment = TextAlignment.left,
  });

  void render(Console console) {
    final int titleLength = title != null ? title!.text.length + 2 : 0;
    final int consoleWidth = console.windowWidth;
    final int panelWidth =
        _calculatePanelWidth(text, titleLength, width, consoleWidth);
    final int widthCompensation = width != null ? 5 : 1;

    if (title != null) {
      final String ptl = title?.style.tl ?? style.tl;
      final String ptr = title?.style.tr ?? style.tr;
      final String pbl = title?.style.bl ?? style.bl;
      final String pbr = title?.style.br ?? style.br;

      console.writeLine('  $ptl${x * (title!.text.length + 2)}$ptr');
      console.writeLine(
          '${style.tl}$x┤ ${title!.text} ├${x * (panelWidth - widthCompensation)}${style.tr}');
      console.writeLine(
          '$y $pbl${x * titleLength}$pbr${" " * (panelWidth - widthCompensation)}$y');
    }

    if (title == null) {
      console.writeLine(
          '${style.tl}${x * (width != null ? panelWidth - 2 : panelWidth + 2)}${style.tr}');
    }

    writeBody(text, alignment, width, console);
    console.writeLine(
        '${style.bl}${'─' * ((panelWidth + 1) - (widthCompensation - 2) + (titleLength))}${style.br}');
  }

  void writeBody(
      String text, TextAlignment alignment, int? width, Console console) {
    final int padding = ((width ?? 0 / 2) - (text.length + 4)).toInt();

    console.write('$y ');
    if (alignment == TextAlignment.right) {
      console.write(' ' * padding);
    }
    if (alignment == TextAlignment.center) console.write(' ' * (padding ~/ 2));
    console.write(text);
    if (alignment == TextAlignment.center) console.write(' ' * (padding ~/ 2));
    if (alignment == TextAlignment.left) {
      console.write(' ' * padding);
    }
    console.write(' $y');
    console.write(console.newLine);
  }

  int _calculatePanelWidth(
    String text,
    int titleLength,
    int? width,
    int consoleWidth,
  ) {
    final int textLength = text.length;

    if (width == null) return textLength - titleLength;
    if (width > consoleWidth) return consoleWidth - titleLength;
    if (width > textLength) return width - titleLength;
    if (width < textLength) return width - titleLength;
    return textLength + titleLength;
  }
}

enum PanelEdgeStyle {
  round('╭', '╮', '╰', '╯'),
  square('┌', '┐', '└', '┘');

  final String tl;
  final String tr;
  final String bl;
  final String br;
  const PanelEdgeStyle(this.tl, this.tr, this.bl, this.br);
}

class PanelTitle {
  final String text;
  final PanelEdgeStyle style;

  const PanelTitle(this.text, {this.style = PanelEdgeStyle.round});
}
