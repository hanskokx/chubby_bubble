enum CornerStyle {
  double('╔', '╗', '╚', '╝'),
  round('╭', '╮', '╰', '╯'),
  square('┌', '┐', '└', '┘');

  final String tl;
  final String tr;
  final String bl;
  final String br;
  const CornerStyle(this.tl, this.tr, this.bl, this.br);
}
