const String x = '─';
const String y = '│';

class Panel {
  final PanelEdgeStyle style;
  final PanelTitle? title;
  final String text;
  final int? width;

  const Panel(
    this.text, {
    this.style = PanelEdgeStyle.round,
    this.title,
    this.width,
  });

  void render() {
    final int titleLength = title != null ? title!.text.length + 2 : 0;
    final int panelWidth = _calculatePanelWidth(text, titleLength, width);
    final int widthCompensation = width != null ? 5 : 1;

    if (title != null) {
      final String ptl = title?.style.tl ?? style.tl;
      final String ptr = title?.style.tr ?? style.tr;
      final String pbl = title?.style.bl ?? style.bl;
      final String pbr = title?.style.br ?? style.br;

      print('  $ptl${x * (title!.text.length + 2)}$ptr');
      print(
          '${style.tl}$x$y ${title!.text} $y${x * (panelWidth - widthCompensation)}${style.tr}');
      print(
          '$y $pbl${x * titleLength}$pbr${" " * (panelWidth - widthCompensation)}$y');
    }

    if (title == null) {
      print('${style.tl}${x * (panelWidth - 2)}${style.tr}');
    }
    print('$y $text ${" " * (panelWidth - titleLength - 4)}$y');
    print(
        '${style.bl}${'─' * ((panelWidth + 1) - (widthCompensation - 2) + (titleLength))}${style.br}');
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
