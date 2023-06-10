class Panel {
  final String? title;
  final String text;
  final int? width;
  final int? height;

  const Panel(
    this.text, {
    this.title,
    this.width,
    this.height,
  });

  void render() {
    final int titleLength = title != null ? title!.length + 2 : 0;
    final int panelWidth = _calculatePanelWidth(text, titleLength, width);
    // final int extraSpace = title != null ? title!.length + 2 : 0;

    print('╭${title != null ? " $title " : ""}${'─' * (panelWidth + 2)}╮');
    print('│ $text │');
    print('╰${'─' * ((panelWidth + 2) + (titleLength))}╯');
  }

  int _calculatePanelWidth(String text, int titleLength, int? width) {
    if (width == null) return text.length - titleLength;
    if (width > text.length) return width - titleLength;
    if (width < text.length) return width - titleLength;
    return text.length - titleLength;
  }
}
